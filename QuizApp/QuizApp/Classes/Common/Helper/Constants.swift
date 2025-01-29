//
//  Constants.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import Foundation
import UIKit

struct AppConstants {
    // MARK: - Animation Constants
    static let splasScreenAnimationTime = 3
    static let quizTransitionTime = 0.5
    static let pickerViewAnimationTime = 0.5

    // MARK: - Size constants
    static let topicsCollectionViewCellLength: CGFloat = 150
    static let quizScreenLengthiPhone: CGFloat = 300
    static let quizScreenLengthiPadPortaint: CGFloat = 400
    static let quizScreenLengthiPadLanscape: CGFloat = 300
    
    // MARK: - User Defaults
    static let userdefaults_isExistingUser = "userdefaults_isExistingUser"
    static let userdefaults_finishedQuizIds = "userdefaults_finishedQuizIds"
    
    // MARK: - Color constants
    
    static let innerPagesBackgroundColor = UIColor(red: 223, green: 243, blue: 192)
    static let splashScreenBackgroundColor = UIColor(red: 54, green: 97, blue: 21)
    static let subSectionColor = UIColor(red: 34, green: 63, blue: 26)
    static let tutorialScreenBackgroundColor = UIColor(red: 153, green: 124, blue: 23)
}
