//
//  LanguagePickerViewModel.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 8/5/22.
//

import Foundation

enum Language: Int, CaseIterable {
    case english
    case spanish
    case hindi
    case marathi
    
    func getLanguage() -> String {
        switch self {
        case .english:
            return "en"
        case .hindi:
            return "hi"
        case .marathi:
            return "mr"
        case .spanish:
            return "es"
        }
    }
    
    func getTextForLanguage() -> String {
        switch self {
        case .english:
            return NSLocalizedString("English", comment: "")
        case .hindi:
            return NSLocalizedString("Hindi", comment: "")
        case .marathi:
            return NSLocalizedString("Marathi", comment: "")
        case .spanish:
            return NSLocalizedString("Spanish", comment: "")
        }
    }
    
}

class LanguagePickerViewModel {
    
    var selectedIndex = 0
    
    func getPickerCount() -> Int {
        return Language.allCases.count
    }
    
    func getPickerTextAtIndex(_ index: Int) -> String {
        let language = Language(rawValue: index) ?? .english
        return language.getTextForLanguage()
    }
    
    func getSelectedLanguage() -> String {
        let language = Language(rawValue: selectedIndex) ?? .english
        return language.getLanguage()
    }

    
}
