//
//  LearnViewController.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import UIKit
import youtube_ios_player_helper

class LearnViewController: UIViewController {
    
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var testButton2: UIButton!
    @IBOutlet weak var doneButton2: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var portraitStackView: UIStackView!
    @IBOutlet weak var landscapeStackView: UIStackView!
    
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    
    var onremoval: (() -> Void)?
    var viewModel: LearnViewModel?
    
    private let buttonBorderColor = UIColor.gray.cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        populateContent()
        addOrientationObsersvers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didChangeOrientation()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        self.view.backgroundColor = AppConstants.innerPagesBackgroundColor
        
        youtubePlayer.backgroundColor = UIColor.clear
        
        testButton.layer.cornerRadius = 5.0
        testButton.layer.borderWidth = 1.0
        testButton.layer.borderColor = buttonBorderColor
        
        doneButton.layer.cornerRadius = 5.0
        doneButton.layer.borderWidth = 1.0
        doneButton.layer.borderColor = buttonBorderColor
        
        testButton2.layer.cornerRadius = 5.0
        testButton2.layer.borderWidth = 1.0
        testButton2.layer.borderColor = buttonBorderColor
        
        doneButton2.layer.cornerRadius = 5.0
        testButton2.layer.borderWidth = 1.0
        testButton2.layer.borderColor = buttonBorderColor
                
        testButton.setTitle(NSLocalizedString("Take_Test", comment: ""), for: .normal)
        testButton2.setTitle(NSLocalizedString("Take_Test", comment: ""), for: .normal)
        doneButton.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
        doneButton2.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)

    }
    
    private func populateContent() {
        self.titleLabel.text = self.viewModel?.getTitle() ?? ""
        playVideo()
    }
    
    private func playVideo() {
        youtubePlayer.load(withVideoId: self.viewModel?.getVideoId() ?? "", playerVars: ["controls":0, "modestbranding":1])
    }
    
    private func addOrientationObsersvers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    @objc func didChangeOrientation() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if UIDevice.current.orientation.isLandscape || UIDevice.current.orientation == .portraitUpsideDown || UIDevice.current.deviceOrientationWithStatusBar == .landscape {
                self.landscapeStackView.isHidden = false
                self.portraitStackView.isHidden = true
            } else {
                self.landscapeStackView.isHidden = true
                self.portraitStackView.isHidden = false
            }
        }
    }
    
    // MARK: - IBACtion
    
    @IBAction func didSelectTestButton(_ sender: Any) {
        dismiss(animated: true)
        self.onremoval?()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
