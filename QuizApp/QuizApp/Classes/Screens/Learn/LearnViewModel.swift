//
//  LearnViewModel.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/17/22.
//

import Foundation

class LearnViewModel {
    
    private var subtopic: Subtopic?
    
    // MARK: - Public Methods
    
    init(subTopic: Subtopic?) {
        self.subtopic = subTopic
    }
    
    // MARK: - Public Methods
    
    func getTitle() -> String {
        return self.subtopic?.subtopicName ?? ""
    }
    
    func getVideoId() -> String {
        let url = self.subtopic?.videoURL ?? ""
        if let _ = URL(string: url) { // If the video is kind of url
            let videoId = getQueryStringParameter(url: url, param: "v")
            return videoId ?? ""
        } else {
            return url
        }
    }
    
    // MARK: - Private Methods
    
    private func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
}
