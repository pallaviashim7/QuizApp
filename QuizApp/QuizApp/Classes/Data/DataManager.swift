//
//  DataManager.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/15/22.
//

import Foundation

class DataManager {
    
    func getMasterData() -> ResponseData? {
        
        var contentJsonPath: URL?
        if let cloudStorageContentPath = FirebaseStorageManager.shared.contentPath {
            contentJsonPath = cloudStorageContentPath
        } else {
            contentJsonPath = Bundle.main.url(forResource: "Contents", withExtension: "json")
        }
        
        if let url = contentJsonPath {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(ResponseData.self, from: jsonData)
                return responseData
            } catch {
                print("\(error)")
            }
        }
        return nil
    }
}
