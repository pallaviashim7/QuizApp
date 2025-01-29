//
//  TopicsCollectionViewCell.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/14/22.
//

import UIKit

class TopicsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var onTopicSelection: ((Topic?, Subtopic?) -> Void)?
    var viewModel: TopicsCollectionViewCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        initializeCollectionView()
    }
    
    // MARK: - Private Methods
    private func initializeCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Collection View

extension TopicsCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfSubTopics() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubTopicsCollectionViewCell", for: indexPath) as? SubTopicsCollectionViewCell else {return UICollectionViewCell()}
        cell.subTopicLabel.text = self.viewModel?.getTopicName(index: indexPath.row) ?? ""
        cell.doneImageView.isHidden = !(self.viewModel?.isTopicsCompleted(index: indexPath.row) ?? false)
        return cell
    }
    
}

extension TopicsCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTopicSelection?(self.viewModel?.getTopic(), self.viewModel?.getSubTopicAt(index: indexPath.row))
    }
    
}

extension TopicsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: AppConstants.topicsCollectionViewCellLength, height: AppConstants.topicsCollectionViewCellLength)
    }
}


