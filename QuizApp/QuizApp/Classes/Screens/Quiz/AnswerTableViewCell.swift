//
//  AnswerTableViewCell.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/19/22.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var labelContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    private func configureView() {
        self.labelContainerView.layer.borderColor = UIColor.lightGray.cgColor
        self.labelContainerView.layer.borderWidth = 2.0
        self.labelContainerView.layer.cornerRadius = 5.0
    }
    
}
