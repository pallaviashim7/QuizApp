//
//  AppFlowManager.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import Foundation

class RootViewModel {
    
    // MARK: - Public Method
    func shouldShowTutorial() -> Bool {
        if PersistedData.isFreshInstall() {
            return true
        } else {
            return false
        }
    }
    
}
