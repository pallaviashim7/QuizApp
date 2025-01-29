//
//  PersistantStorage.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import Foundation

class PersistedData {
    
    // MARK: - Public Methods
    
    class func isFreshInstall() -> Bool {
        let isExistingUser = (userSettingsForKey(AppConstants.userdefaults_isExistingUser) as? Bool) ?? false
        if isExistingUser {
            return false
        } else {
            addUserSettingsForKey(AppConstants.userdefaults_isExistingUser, value: true)
            return true
        }
    }
    
    class func saveFinishedTopic(_ topicId: String) {
        var finishedTopicList: [String] = []
        if let savedFinishedList = getFinishedTopics() {
            finishedTopicList = savedFinishedList
        }
        finishedTopicList.append(topicId)
        addUserSettingsForKey(AppConstants.userdefaults_finishedQuizIds, value: finishedTopicList)
    }
    
    class func getFinishedTopics() -> [String]? {
        return userSettingsForKey(AppConstants.userdefaults_finishedQuizIds) as? [String]
    }
    
    
    // MARK: - Userdefaults
    // MARK: - Add Data
    private class func addUserSettingsForKey(_ key: String?, value: Any?) {
        UserDefaults.standard.set(value, forKey: key ?? "")
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Retrieve data
    private class func userSettingsForKey(_ key: String?) -> Any? {
        return UserDefaults.standard.value(forKey: key ?? "")
    }
    
    // MARK: - Delete Data
    private class func deleteSettingsForKey(_ key: String?) {
        UserDefaults.standard.removeObject(forKey: key ?? "")
        UserDefaults.standard.synchronize()
    }

}
