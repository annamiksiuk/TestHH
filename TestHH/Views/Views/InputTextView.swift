//
//  InputTextView.swift
//  TestHH
//
//  Created by Anna Miksiuk on 25.01.2019.
//  Copyright © 2019 Anna Miksiuk. All rights reserved.
//

import UIKit

protocol InputTextViewDelegate {
    func didTapForgetPassword(inputTextView: InputTextView)
    func didTapReturn(inputTextView: InputTextView)
}

enum InputTextType {
    case email, password
}

class InputTextView: UIView {

    // MARK: IBOutlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var forgetButton: UIButton!
    
    // MARK: - Properties
    
    var type = InputTextType.email {
        didSet {
            configureWithType()
        }
    }
    var delegate: InputTextViewDelegate?
    private var password = ""
    private let titleLetterSpacing: CGFloat = 0.12
    private let textFieldLetterSpacing: CGFloat = -0.33
    private let buttonLetterSpacing: CGFloat = -0.12
    
    // MARK: - Actions
    
    @IBAction func actionForgetPassword(_ sender: UIButton) {
        delegate?.didTapForgetPassword(inputTextView: self)
    }
    
    // MARK: - View lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Self initializations
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("InputTextView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.whiteThree.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
        textField.defaultTextAttributes.updateValue(-0.33, forKey: NSAttributedString.Key.kern)
        
        forgetButton.layer.borderColor = UIColor.whiteThree.cgColor
        forgetButton.layer.borderWidth = 0.6
        forgetButton.layer.cornerRadius = 4
        forgetButton.clipsToBounds = true
        forgetButton.addLettersSpacing(spacing: buttonLetterSpacing)
        
        configureWithType()
        
        textField.delegate = self
    }
    
    private func configureWithType() {
        
        switch type {
        case .email:
            titleLabel.text = "Почта"
            titleLabel.addLettersSpacing(spacing: titleLetterSpacing)
            forgetButton.isHidden = true
        case .password:
            titleLabel.text = "Пароль"
            titleLabel.addLettersSpacing(spacing: titleLetterSpacing)
            forgetButton.isHidden = false
        }
        
    }
    
    // MARK: - Methods
    
    func getTypingValue() -> String {
        if type == .password {
            return password
        }
        return textField.text ?? ""
    }
    
}

// MARK: - UITextFieldDelegate

extension InputTextView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didTapReturn(inputTextView: self)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text), type == .password {
            
            password = password.replacingCharacters(in: textRange, with: string)
            
            textField.text = String(repeating: "*", count: password.count)
            return false
        }
        return true
    }
}


