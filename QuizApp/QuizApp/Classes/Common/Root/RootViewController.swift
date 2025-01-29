//
//  ViewController.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import UIKit

class RootViewController: UIViewController {
    
    private var viewModel = RootViewModel()
    
    // MARK: - View Lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        showSplashScreen()
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func showSplashScreen() {
        // Subview splash screen
        let splashViewController = SplashViewController.instantiateViewController("SplashViewController")
        self.navigationController?.pushViewController(splashViewController, animated: false)
        
        // Remove splash screen
        let dispatchAfter = DispatchTimeInterval.seconds(AppConstants.splasScreenAnimationTime)
        DispatchQueue.main.asyncAfter(deadline: .now() + dispatchAfter) {
            splashViewController.dismiss(animated: false)
            self.showNextScreenAfterSplash()
        }
    }
    
    private func showNextScreenAfterSplash() {
        if viewModel.shouldShowTutorial() {
            showTutorialScreen()
        } else {
            showTopicsScreen()
        }
    }
    
    private func showTutorialScreen() {
        let tutorialViewController = TutorialViewController.instantiateViewController("TutorialViewController")
        tutorialViewController.onremoval = { [weak self] in
            self?.showTopicsScreen()
        }
        self.navigationController?.pushViewController(tutorialViewController, animated: true)
        
    }
    
    private func showTopicsScreen() {
        let topicsViewController = TopicsViewController.instantiateViewController("TopicsViewController")
        self.navigationController?.pushViewController(topicsViewController, animated: true)
    }
    
}




