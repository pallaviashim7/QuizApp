//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/16/22.
//

import Foundation

class QuizViewModel {
    
    private var subtopic: Subtopic?
    private var quizCounter = 0
    
    // MARK: - Public Methods
    
    init(subTopic: Subtopic?) {
        self.subtopic = subTopic
    }
    
    // MARK: - QuizView Transition
    
    func isLeftArrowEnabled() -> Bool {
        var enabled = true
        if quizCounter == 0 {
            enabled = false
        }
        return enabled
    }
    
    func isRightArrowEnabled() -> Bool {
        var enabled = true
        if (quizCounter + 1) == (subtopic?.quiz.count ?? 0) {
            enabled = false
        }
        return enabled
    }
    
    func shouldRemoveOldQuiz() -> Bool {
        return false
    }
    
    func nextQuizAvailable() -> Bool {
        return true
    }
    
    func requestedForNextQuiz() {
        let nextQuizIndex = quizCounter + 1
        if (subtopic?.quiz.count ?? 0) > nextQuizIndex {
            quizCounter = nextQuizIndex
        }
    }
    
    func requestedForPreviousQuiz() {
        let previousQuizIndex = quizCounter - 1
        if (subtopic?.quiz.count ?? 0) >= previousQuizIndex {
            quizCounter = previousQuizIndex
        }
    }
    
    func markSubTopicAsCompleted() {
        PersistedData.saveFinishedTopic(self.subtopic?.subtopicID ?? "")
    }
    
    // MARK: - QuizView Content
    
    enum QuizState {
        case answered
        case notanswered
    }
    
    private var datasource: [AnswerList] = []
    private var userAnswered: String = ""
    
    func updateDataSourceForState(_ state: QuizState, answerId: String? = nil) {
        datasource = []
        userAnswered = answerId ?? ""
        switch state {
        case .answered:
            let answerList = subtopic?.quiz[quizCounter].answerList
            let filtered = answerList?.filter { ($0.answerID) == (answerId ?? "") }
            datasource.append(contentsOf: filtered ?? [])
        case .notanswered:
            datasource.append(contentsOf: subtopic?.quiz[quizCounter].answerList ?? [])
        }
    }
    
    func didAnswerCorrectly() -> Bool {
        return (subtopic?.quiz[quizCounter].correctAnswerID ?? "") == userAnswered
    }
    
    func getCorrectAnswerText() -> String {
        let answerList = subtopic?.quiz[quizCounter].answerList
        let correctAnswerId = subtopic?.quiz[quizCounter].correctAnswerID ?? ""
        let filtered = answerList?.filter { ($0.answerID) == correctAnswerId }.first
        let correctAnswer = filtered?.answerText ?? ""
        let resultText = didAnswerCorrectly() ? "\(NSLocalizedString("That_right", comment: ""))" : "\(NSLocalizedString("Oops_wrong", comment: "")): \(correctAnswer)"
        return "\(resultText)"
    }
    
    func getQuestionText() -> String {
        return subtopic?.quiz[quizCounter].question ?? ""
    }
    
    func getAnswerOptionsCount() -> Int {
        return datasource.count
    }
    
    func getAnswerTextAtIndex(_ index: Int) -> String {
        return datasource[index].answerText
    }
    
    func getAnswerIdAtIndex(_ index: Int) -> String {
        return datasource[index].answerID
    }
    
    func didFinishQuiz() -> Bool {
        return (subtopic?.quiz.count ?? 0) == (quizCounter + 1)
    }
    
}
