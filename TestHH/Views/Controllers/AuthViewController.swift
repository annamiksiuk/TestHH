//
//  AuthViewController.swift
//  TestHH
//
//  Created by Anna Miksiuk on 25.01.2019.
//  Copyright © 2019 Anna Miksiuk. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var emailView: InputTextView!
    @IBOutlet weak var passwordView: InputTextView!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var centerYStackViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    // MARK: - Actions
    
    @IBAction func actionSign(_ sender: UIButton) {
        
        guard !emailView.getTypingValue().isEmpty, !passwordView.getTypingValue().isEmpty else {
            present(alertOk(message: "Укажите почту и пароль!"), animated: true, completion: nil)
            return
        }
        
        if !validateString(text: emailView.getTypingValue(), type: .email) {
            present(alertOk(message: "Почта введена не корректно!"), animated: true, completion: nil)
            emailView.textField.becomeFirstResponder()
            return
        }
        
        if !validateString(text: passwordView.getTypingValue(), type: .password) {
            present(alertOk(message: "Пароль не достаточно надежен!"), animated: true, completion: nil)
            passwordView.textField.becomeFirstResponder()
            return
        }
        
        showWeather()
    }
    
    @IBAction func actionCreateAccount(_ sender: UIButton) {
        present(alertOk(message: "Давайте создадим ваш новый аккаунт!"), animated: true, completion: nil)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Self initializations
    
    private func commonInit() {
        
        emailView.type = .email
        passwordView.type = .password
        
        emailView.delegate = self
        passwordView.delegate = self
        
        signButton.layer.cornerRadius = signButton.bounds.height / 2
        signButton.clipsToBounds = true
        signButton.addLettersSpacing(spacing: -0.24)
        
        createButton.addLettersSpacing(spacing: -0.15)
    }
    
    // MARK: - Private
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardEndSize = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) {
            if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {

                centerYStackViewConstraint.constant = -keyboardEndSize.height / 2
                UIView.animate(withDuration: animationDuration) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            centerYStackViewConstraint.constant = 0
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func showWeather() {
        
        let city = "Minsk"
        var weatherMessage = "Получить данные о погоде не удалось("
        WeatherService().weather(city: city) { [weak self] (model) in
            if let weatherModel = model {
                let temp = weatherModel.main.temp - 273.15  //перевод кельвин в градусы
                weatherMessage = "\(city) - \(temp), \(weatherModel.weather.first?.description ?? ""), wind speed - \(weatherModel.wind.speed)"
                
            }
            DispatchQueue.main.async {
                self?.passwordView.textField.resignFirstResponder()
                self?.present(alertOk(message: weatherMessage), animated: true, completion: nil)
            }
        }
    }
}

// MARK: - InputTextViewDelegate

extension AuthViewController: InputTextViewDelegate {
    
    func didTapForgetPassword(inputTextView: InputTextView) {
        present(alertOk(message: "Вы забыли пароль, а это очень плохо!"), animated: true, completion: nil)
    }
    
    func didTapReturn(inputTextView: InputTextView) {
        if inputTextView == emailView {
            passwordView.textField.becomeFirstResponder()
        } else {
            passwordView.textField.resignFirstResponder()
            if !emailView.getTypingValue().isEmpty || !passwordView.getTypingValue().isEmpty {
                actionSign(signButton.self)
            }
        }
    }
}
