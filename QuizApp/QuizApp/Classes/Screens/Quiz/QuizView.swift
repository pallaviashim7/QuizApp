//
//  QuizView.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/17/22.
//

import Foundation
import UIKit

class QuizView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var answerTableView: UITableView!

    
    var onCompletion: (() -> Void)?
    
    private var viewModel: QuizViewModel?
    private var didSelectOnce = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Public Methods
    
    class func instantiateWith(viewModel: QuizViewModel?) -> QuizView? {
        let view = UINib(nibName: "QuizView", bundle: .main).instantiate(withOwner: nil, options: nil).first as? QuizView
        view?.viewModel = viewModel
        view?.viewModel?.updateDataSourceForState(.notanswered)
        view?.reloadContent()
        return view
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        self.containerView.backgroundColor = AppConstants.subSectionColor
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = UIColor.white.cgColor
        self.containerView.layer.borderWidth = 1.0
        
        answerTableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell")
        answerTableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "QuestionTableViewCell")

        answerTableView.dataSource = self
        answerTableView.delegate = self
        
        answerTableView.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        answerTableView.estimatedSectionFooterHeight = CGFloat.leastNormalMagnitude
        answerTableView.sectionFooterHeight = UITableView.automaticDimension
        answerTableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    private func reloadContent() {
        self.answerTableView.reloadData()
    }
    
}

extension QuizView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
        headerCell.headerLabel.text = viewModel?.getQuestionText() ?? ""
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if didSelectOnce {
            let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
            headerCell.headerLabel.text = viewModel?.getCorrectAnswerText() ?? ""
            return headerCell
        } else {
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getAnswerOptionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell") as? AnswerTableViewCell else {return UITableViewCell()}
        cell.contentLabel.text = viewModel?.getAnswerTextAtIndex(indexPath.row) ?? ""
        if didSelectOnce {
            if viewModel?.didAnswerCorrectly() ?? false {
                cell.labelContainerView.backgroundColor = UIColor(rgb: 0x6D8632)
            } else {
                cell.labelContainerView.backgroundColor = UIColor(rgb: 0x552A0E)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension QuizView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !didSelectOnce {
            didSelectOnce = true
            viewModel?.updateDataSourceForState(.answered, answerId: viewModel?.getAnswerIdAtIndex(indexPath.row))
            self.reloadContent()
            if viewModel?.didFinishQuiz() ?? false {
                onCompletion?()
            }
        }
        
    }
    
}
