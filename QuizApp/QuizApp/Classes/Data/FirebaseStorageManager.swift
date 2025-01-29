//
//  FirebaseStorageManager.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/23/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    var contentPath: URL?
    init() {
        FirebaseApp.configure()
    }
    
    func initialize() {
        let storage = Storage.storage()
        let pathReference = storage.reference(withPath: "Contents.json")
        let documentsDirectoryPath = getDocumentsDirectory()
        guard let jsonFilePath = URL(string: "\(documentsDirectoryPath.absoluteString)/Contents.json") else {return}
        // Download to the local filesystem
        pathReference.write(toFile: jsonFilePath) { url, error in
          if let error = error {
            // Uh-oh, an error occurred!
              print(error)
          } else {
            // Local file URL for "images/island.jpg" is returned
              self.contentPath = url
              print("\(String(describing: url))")
          }
        }

    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
