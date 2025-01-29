//
//  LanguagePickerViewController.swift
//  QuizApp
//
//  Created by Pallavi Ashim on 8/5/22.
//

import UIKit

class LanguagePickerViewController: UIViewController {

    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    private var viewModel = LanguagePickerViewModel()
    
    var dismissClosure: (() -> Void)?
    var selectLanguage: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        pickerContainerView.backgroundColor = AppConstants.innerPagesBackgroundColor
        self.navBarView.backgroundColor = AppConstants.subSectionColor
        pickerView.delegate = self
        pickerView.dataSource = self
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        navBarView.layer.cornerRadius = 20
        languageLabel.text = NSLocalizedString("Language", comment: "")
    }
    
    // MARK: - IBAction
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissClosure?()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        selectLanguage?(viewModel.getSelectedLanguage())
    }
    
}

extension LanguagePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return viewModel.getPickerCount()
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return viewModel.getPickerTextAtIndex(row)
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedIndex = row
    }
}
