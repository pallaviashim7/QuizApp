//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import UIKit

enum QuizDirection {
    case forward
    case backward
}

class QuizViewController: UIViewController {
        
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var rightArrowButton: UIButton!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var topicCompletedView: UIView!
    @IBOutlet weak var arrowStackView: UIStackView!
    @IBOutlet weak var congratsDescription: UILabel!
    @IBOutlet weak var congratsTitleLabel: UILabel!
    @IBOutlet weak var arrowBottomconstraint: NSLayoutConstraint!
    
    var onremoval: ((Bool) -> Void)? // Pass in the completed status
    var viewModel: QuizViewModel?
    
    private var quizViewOnDisplay: QuizView?
    private var quizScreenLength: CGFloat = 0
    private var centerXAnchorOfQuizViewOnDisplay: NSLayoutConstraint?
    private var isFirstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addOrientationObsersvers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.userInterfaceIdiom == .phone {
            Globals.lockOrientation(.portrait, andRotateTo: .portrait)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLoad {
            isFirstLoad = false
            refreshScreen(direction: .forward)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Globals.lockOrientation(.all)
    }
    
    // MARK : - Private Methods
    
    private func configure() {
        self.view.backgroundColor = AppConstants.innerPagesBackgroundColor
        if UIScreen.main.bounds.height == 667 {
            arrowBottomconstraint.constant = 120
        }
        quizScreenLength = getQuizScreenLength()
        setArrowButtons()
        topicCompletedView.isHidden = true
        congratsTitleLabel.text = NSLocalizedString("Congrats", comment: "")
        congratsDescription.text = NSLocalizedString("Congrats_description", comment: "")

    }
    
    private func getQuizScreenLength() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AppConstants.quizScreenLengthiPhone
        } else if UIDevice.current.deviceOrientationWithStatusBar == .landscape {
            return AppConstants.quizScreenLengthiPadLanscape
        } else {
            return AppConstants.quizScreenLengthiPadPortaint
        }
    }
    
    private func addOrientationObsersvers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func didChangeOrientation() {
        quizScreenLength = getQuizScreenLength()
        
        if let constraints = quizViewOnDisplay?.constraints {
            for eachConstraint in constraints {
                if eachConstraint.firstAttribute == .height ||
                    eachConstraint.firstAttribute == .width {
                    eachConstraint.constant = quizScreenLength
                }
            }
        }
        view.layoutIfNeeded()
    }
    
    private func refreshScreen(direction: QuizDirection) {
        showQuiz(direction: direction)
        setArrowButtons()
    }
    
    private func setArrowButtons() {
        self.leftArrowButton.isEnabled = viewModel?.isLeftArrowEnabled() ?? true
        self.leftArrowButton.tintColor = (viewModel?.isLeftArrowEnabled() ?? true) ? .black: .placeholderText
        self.rightArrowButton.isEnabled = (viewModel?.isRightArrowEnabled() ?? true)
        self.rightArrowButton.tintColor = (viewModel?.isRightArrowEnabled() ?? true) ? .black: .placeholderText
    }
    
    
    private func showQuiz(direction: QuizDirection) {
        switch direction {
        case .forward:
            if viewModel?.isLeftArrowEnabled() ?? false {
                removeQuizOnDisplayToLeft()
            }
            bringQuizToDisplayFromRight()
        case .backward:
            removeQuizOnDisplayToRight()
            bringQuizToDisplayFromLeft()
        }
    }
    
    private func removeQuizOnDisplayToRight() {
        centerXAnchorOfQuizViewOnDisplay?.constant = 0
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: AppConstants.quizTransitionTime) {
            self.quizViewOnDisplay?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.centerXAnchorOfQuizViewOnDisplay?.constant = UIScreen.main.bounds.width
            self.view.layoutIfNeeded()
        }
    }
    
    private func removeQuizOnDisplayToLeft() {
        centerXAnchorOfQuizViewOnDisplay?.constant = 0
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: AppConstants.quizTransitionTime) {
            self.quizViewOnDisplay?.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi * 99.9 / 100))
            self.centerXAnchorOfQuizViewOnDisplay?.constant = -UIScreen.main.bounds.width
            self.view.layoutIfNeeded()
        }
    }
    
    private func bringQuizToDisplayFromLeft() {
        let initialXPosition = -UIScreen.main.bounds.width
        let newQuiz = addNewQuizOnScreen(centerX: 0)
        let quizView = newQuiz.0
        let centerXConstraint = newQuiz.1
        quizView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        centerXConstraint?.constant = initialXPosition
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: AppConstants.quizTransitionTime) {
            quizView?.transform = CGAffineTransform(rotationAngle: 2 * CGFloat.pi)
            centerXConstraint?.constant = 0
            self.view.layoutIfNeeded()
        } 
        centerXAnchorOfQuizViewOnDisplay = centerXConstraint
        quizViewOnDisplay = quizView
    }
    
    private func bringQuizToDisplayFromRight() {
        let initialXPosition = UIScreen.main.bounds.width
        let newQuiz = addNewQuizOnScreen(centerX: 0)
        let quizView = newQuiz.0
        let centerXConstraint = newQuiz.1
        quizView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        centerXConstraint?.constant = initialXPosition
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: AppConstants.quizTransitionTime) {
            quizView?.transform = CGAffineTransform(rotationAngle: -2*(CGFloat.pi * 99.9 / 100))
            centerXConstraint?.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            quizView?.transform = CGAffineTransform(rotationAngle: -2*(CGFloat.pi))
        }
        centerXAnchorOfQuizViewOnDisplay = centerXConstraint
        quizViewOnDisplay = quizView
        
    }
    
    
    private func addNewQuizOnScreen(centerX: CGFloat) -> (QuizView?, NSLayoutConstraint?) {
        if let quizView = QuizView.instantiateWith(viewModel: self.viewModel) {
            quizView.onCompletion = { [weak self] in
                self?.didFinishQuiz()
            }
            self.view.addSubview(quizView)
            let widthConstraint = quizView.widthAnchor.constraint(equalToConstant: quizScreenLength)
            let heightConstraint = quizView.heightAnchor.constraint(equalToConstant: quizScreenLength)
            let centerXConstraint = NSLayoutConstraint(item: quizView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: centerX)
            let topConstraint = NSLayoutConstraint(item: quizView, attribute: .top, relatedBy: .equal, toItem: headingLabel, attribute: .bottom, multiplier: 1.0, constant: 60)
            quizView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([widthConstraint, heightConstraint, centerXConstraint, topConstraint])
            return (quizView, centerXConstraint)
        }
        return (nil, nil)
    }
    
    private func didFinishQuiz() {
        self.leftArrowButton.isHidden = true
        self.rightArrowButton.isEnabled = true
        self.rightArrowButton.tintColor = .black
    }
    
    private func configureForTopicCompletion() {
        self.arrowStackView.isHidden = true
        self.topicCompletedView.isHidden = false
        self.topicCompletedView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.quizViewOnDisplay?.alpha = 0
            self.topicCompletedView.alpha = 1
        }
        self.viewModel?.markSubTopicAsCompleted()
    }


    // MARK : - IBActions
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
        onremoval?(viewModel?.didFinishQuiz() ?? false)
    }
    
    @IBAction func leftArrowButtonTapped(_ sender: Any) {
        self.viewModel?.requestedForPreviousQuiz()
        self.refreshScreen(direction: .backward)
    }
    
    @IBAction func rightArrowButtonTapped(_ sender: Any) {
        if viewModel?.didFinishQuiz() ?? false {
            configureForTopicCompletion()
        } else {
            self.viewModel?.requestedForNextQuiz()
            self.refreshScreen(direction: .forward)
        }

    }
    
}
