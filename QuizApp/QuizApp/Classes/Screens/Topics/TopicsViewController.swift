//
//  TopicsViewController.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import UIKit

class TopicsViewController: UIViewController {
    
    private var viewModel = TopicsViewModel()
    
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayButton: UIView!
    private var languagePickerVC: LanguagePickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppConstants.innerPagesBackgroundColor
        configureCollectionView()
    }
    
    // MARK: - Private Methods
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func showLearnScreen() {
        let learnViewController = LearnViewController.instantiateViewController("LearnViewController")
        learnViewController.onremoval = {[weak self] in
            self?.showQuizScreen()
        }
        learnViewController.viewModel = LearnViewModel(subTopic: viewModel.getLearningSubTopic())
        self.present(learnViewController, animated: true)
    }
    
    private func showQuizScreen() {
        let quizViewController = QuizViewController.instantiateViewController("QuizViewController")
        quizViewController.onremoval = { [weak self] didCompleteSubTopic in
            if didCompleteSubTopic {
                self?.reloadData()
            }
        }
        quizViewController.presentationController?.delegate = self
        quizViewController.viewModel = QuizViewModel(subTopic: self.viewModel.getLearningSubTopic())
        self.present(quizViewController, animated: true)
    }
    
    private func reloadData() {
        self.collectionView.reloadData()
    }
    
    private func addPickerView() {
        
        if languagePickerVC != nil {
            dismissPickerView()
            return
        }
        
        let pickerVC = LanguagePickerViewController.instantiateViewController("LanguagePickerViewController")
        pickerVC.view.translatesAutoresizingMaskIntoConstraints = false
        pickerVC.dismissClosure = { [weak self] in
            self?.dismissPickerView()
        }
        pickerVC.selectLanguage = { [weak self] lan in
            self?.dismissPickerView()
            self?.didSelectLanguage(lan)
        }

        view.addSubview(pickerVC.view)
        self.pickerContainerView.bringSubviewToFront(pickerVC.view)
        self.languagePickerVC = pickerVC
        pickerVC.view.leadingAnchor.constraint(equalTo: pickerContainerView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pickerVC.view.trailingAnchor.constraint(equalTo: pickerContainerView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pickerVC.view.bottomAnchor.constraint(equalTo: pickerContainerView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.showPickerView()
    }
    
    private func didSelectLanguage(_ language: String) {
        let lang = language
        let defaults = UserDefaults.standard
        defaults.set([lang], forKey: "AppleLanguages")
        defaults.synchronize()
        Bundle.setLanguage(lang)
    }
    
    private func showPickerView() {
        self.pickerContainerView.isHidden = false
        self.overlayButton.isHidden = false
        self.bottomConstraint.constant = -300
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: AppConstants.pickerViewAnimationTime) {
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func dismissPickerView() {
        self.bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: AppConstants.pickerViewAnimationTime) {
            self.bottomConstraint.constant = -300
            self.view.layoutIfNeeded()
        } completion: { finish in
            self.languagePickerVC?.view.removeFromSuperview()
            self.languagePickerVC = nil
            self.pickerContainerView.isHidden = true
            self.overlayButton.isHidden = true
        }
    }
    
    // MARK: - IBACtion
    @IBAction func didTapTutorialButton(_ sender: Any) {
        let tutorialViewController = TutorialViewController.instantiateViewController("TutorialViewController")
        self.present(tutorialViewController, animated: true)
    }
    
    @IBAction func didTapOverLayButton(_ sender: Any) {
        dismissPickerView()
    }
    
    @IBAction func didTapSettingsScreen(_ sender: Any) {
        addPickerView()
    }
}

extension TopicsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.reloadData()
    }
}

// MARK: - CollectionView

extension TopicsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.totalNumberOfTopics()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicsCollectionViewCell", for: indexPath) as? TopicsCollectionViewCell else {return UICollectionViewCell()}
        cell.onTopicSelection = { [weak self] (topic, subTopic) in
            self?.viewModel.learningSubTopic(subTopic, from: topic)
            self?.showLearnScreen()
        }
        cell.viewModel = TopicsCollectionViewCellViewModel(topic: self.viewModel.getTopicAtIndex(indexPath.section))
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TopicsCollectionReusableView", for: indexPath) as? TopicsCollectionReusableView else {return UICollectionReusableView()}
            headerView.headingLabel.text = viewModel.getHeadingForTopicAtIndex(indexPath.section)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension TopicsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: AppConstants.topicsCollectionViewCellLength + 20)
    }
}






