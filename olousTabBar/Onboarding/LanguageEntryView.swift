//
//  LanguageEntryView.swift
//  olousTabBar
//
//  Created by Salt Technologies on 17/04/24.
//

import UIKit

class LanguageEntryView: UIView {
    
    let languagePicker = UIPickerView()
    let fluencyPicker = UIPickerView()
    let languageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Language"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let fluencyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select Fluency Level"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal) // Requires SF Symbols which is available from iOS 13
        button.tintColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(languageTextField)
        addSubview(fluencyTextField)
        
        languagePicker.tag = 0
        fluencyPicker.tag = 1
        languageTextField.inputView = languagePicker
        fluencyTextField.inputView = fluencyPicker
        
        languageTextField.translatesAutoresizingMaskIntoConstraints = false
        fluencyTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            languageTextField.topAnchor.constraint(equalTo: topAnchor),
            languageTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            languageTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4, constant: -10),
            
            fluencyTextField.topAnchor.constraint(equalTo: topAnchor),
            fluencyTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            fluencyTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4, constant: -10),
        ])
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteButton)
        
        // Set up constraints for the addButton and deleteButton
        NSLayoutConstraint.activate([
            
            deleteButton.topAnchor.constraint(equalTo: fluencyTextField.bottomAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            deleteButton.widthAnchor.constraint(equalToConstant: 44),
            deleteButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true

    }
}
