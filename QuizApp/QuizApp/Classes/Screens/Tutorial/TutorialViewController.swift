//
//  TutorialViewController.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 7/13/22.
//

import UIKit

class TutorialViewController: UIViewController {
    
    var onremoval: (() -> Void)?
    @IBOutlet weak var acknowledgementTextView: UITextView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.userInterfaceIdiom == .phone {
            Globals.lockOrientation(.portrait, andRotateTo: .portrait)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Globals.lockOrientation(.all)
    }
    
    private func configure() {
//        self.contentLabel.text = NSLocalizedString("Tutorial_content", comment: "")
//        self.versionLabel.text = "\(NSLocalizedString("Version", comment: "")) 1.0"
        doneButton.setTitle(NSLocalizedString("Start_Your_Journey", comment: ""), for: .normal)
        doneButton.layer.cornerRadius = 5.0
        acknowledgementTextView.attributedText = getAddAcknowledgementText()
        self.view.backgroundColor = AppConstants.tutorialScreenBackgroundColor
    }
    
    private func getAddAcknowledgementText() -> NSAttributedString {
        let content = NSMutableAttributedString()
        
        let acknowledgement = "\(NSLocalizedString("Acknowledgements", comment: ""))\n"
        let ackAttr = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        let ackAttrString = NSAttributedString(string: acknowledgement, attributes: ackAttr)
        content.append(ackAttrString)

        
        let bulletPoint = "\u{2192}"
        let bulletPointAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]
        let bulletAttrString = NSAttributedString(string: bulletPoint, attributes: bulletPointAttr)
        content.append(bulletAttrString)
        
        let pointOne = " Investopedia\n"
        let pointOneAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                            NSAttributedString.Key.link: "https://www.investopedia.com"] as [NSAttributedString.Key : Any]
        let pointOneAttrString = NSAttributedString(string: pointOne, attributes: pointOneAttr)
        content.append(pointOneAttrString)
        

        content.append(bulletAttrString)
        let point2 = " St. Louis Fed\n"
        let point2Attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                          NSAttributedString.Key.link: "https://www.stlouisfed.org/education"] as [NSAttributedString.Key : Any]
        let point2AttrString = NSAttributedString(string: point2, attributes: point2Attr)
        content.append(point2AttrString)
        
        content.append(bulletAttrString)
        let point3 = " MathsIsFun\n"
        let point3Attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                          NSAttributedString.Key.link: "https://www.mathsisfun.com"] as [NSAttributedString.Key : Any]
        let point3AttrString = NSAttributedString(string: point3, attributes: point3Attr)
        content.append(point3AttrString)
        
        content.append(bulletAttrString)
        let point4 = " Nerdwallet\n"
        let point4Attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                          NSAttributedString.Key.link: "https://www.nerdwallet.com"] as [NSAttributedString.Key : Any]
        let point4AttrString = NSAttributedString(string: point4, attributes: point4Attr)
        content.append(point4AttrString)
        
        return content
    }
    
    
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        var shouldAnimateOut = true
        if self.navigationController != nil {
            shouldAnimateOut = false
        }
        self.dismiss(animated: shouldAnimateOut)
        self.onremoval?()
    }
    
}
