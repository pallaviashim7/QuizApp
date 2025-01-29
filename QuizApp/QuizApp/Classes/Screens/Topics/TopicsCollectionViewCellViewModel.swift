//
//  TopicsCollectionViewCellViewModel.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/15/22.
//

import Foundation
import UIKit

class TopicsCollectionViewCellViewModel {
    
    private var topic: Topic?
    
    init(topic: Topic?) {
        self.topic = topic
    }
    
    // MARK: - Public Methods
    func getNumberOfSubTopics() -> Int {
        return self.topic?.subtopics.count ?? 0
    }
    
    func isTopicsCompleted(index: Int) -> Bool {
        var isCompleted = false
        let finishedTopics = PersistedData.getFinishedTopics() ?? []
        guard let currentSubTopic = topic?.subtopics[index].subtopicID else { return false}
        if finishedTopics.contains(currentSubTopic) {
            isCompleted = true
        }
        return isCompleted
    }
    
    func getTopicName(index: Int) -> String {
        self.topic?.subtopics[index].subtopicName ?? ""
    }
    
    func getTopic() -> Topic? {
        return self.topic
    }
    
    func getSubTopicAt(index: Int) -> Subtopic? {
        return self.topic?.subtopics[index]
    }
    
}
