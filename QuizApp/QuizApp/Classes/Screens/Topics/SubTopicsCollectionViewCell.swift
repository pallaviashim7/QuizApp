//
//  TopicsCollectionViewCell.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/14/22.
//

import UIKit

class SubTopicsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subTopicLabel: UILabel!
    @IBOutlet weak var doneImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - UI Design
    private func configureUI() {
        self.backgroundColor = AppConstants.subSectionColor
        addBorder()
        addshadow()
    }
    
    private func addBorder() {
//        self.contentView.layer.borderWidth = 1
//        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.cornerRadius = 10
    }
    
    private func addshadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
    
}
