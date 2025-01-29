//
//  DataModels.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/14/22.
//

import Foundation

import Foundation

// MARK: - ResponseData
struct ResponseData: Codable {
    let topics: [Topic]
}

// MARK: - Topic
struct Topic: Codable {
    let topicID, topicName, topicDescription: String
    let subtopics: [Subtopic]

    enum CodingKeys: String, CodingKey {
        case topicID = "topicId"
        case topicName, topicDescription, subtopics
    }
}

// MARK: - Subtopic
struct Subtopic: Codable {
    let subtopicID, subtopicName, subtopicDescription: String
    let videoURL: String
    let quiz: [Quiz]

    enum CodingKeys: String, CodingKey {
        case subtopicID = "subtopicId"
        case subtopicName, subtopicDescription, videoURL, quiz
    }
}

// MARK: - Quiz
struct Quiz: Codable {
    let quizID, question, correctAnswerID: String
    let answerList: [AnswerList]

    enum CodingKeys: String, CodingKey {
        case quizID = "quizId"
        case question
        case correctAnswerID = "correctAnswerId"
        case answerList
    }
}

// MARK: - AnswerList
struct AnswerList: Codable {
    let answerID, answerText: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answerId"
        case answerText
    }
}
