//
//  TopicsViewModel.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/15/22.
//

import Foundation

class TopicsViewModel {
    
    private var masterData: ResponseData?
    private var learningTopic: Topic?
    private var learningSubTopic: Subtopic?
    
    init() {
        let datamanager = DataManager()
        masterData = datamanager.getMasterData()
    }
    
    // MARK: - Public Methods
    
    func totalNumberOfTopics() -> Int {
        return masterData?.topics.count ?? 0
    }
    
    func getTopicAtIndex(_ index: Int) -> Topic? {
        return masterData?.topics[index]
    }
    
    func getHeadingForTopicAtIndex(_ index: Int) -> String {
        return masterData?.topics[index].topicName ?? ""
    }
    
    func learningSubTopic(_ subTopic: Subtopic?, from topic: Topic?) {
        self.learningTopic = topic
        self.learningSubTopic = subTopic
    }
    
    func getLearningSubTopic() -> Subtopic? {
        return self.learningSubTopic
    }
     
}
