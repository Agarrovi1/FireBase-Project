//
//  LoginVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - UI Objects
    var logoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "FireBase-Project"
        label.font = UIFont(name: "Verdana-Bold", size: 30)
        label.textColor = UIColor.white
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.font = UIFont(name: "Verdana", size: 14)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
//        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.font = UIFont(name: "Verdana", size: 14)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
//        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
        button.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
        return button
    }()
    var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ",attributes: [
            NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!,
            NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign Up",
                                                  attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana-Bold", size: 14)!,
                                                               NSAttributedString.Key.foregroundColor:  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        //        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        return button
    }()
    
    var redView = RedScreen()
    
    //MARK: - Constraints
    private func setupLogInUI() {
        setRedViewConstraints()
        setLogoConstraints()
        setEmailTextFieldConstraints()
        setPasswordTextFieldConstraints()
        setLogInButtonConstraints()
        setSignInButtonConstraints()
    }
    private func setRedViewConstraints() {
        view.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        redView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        redView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    private func setLogoConstraints() {
        view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 60)])
    }
    private func setEmailTextFieldConstraints() {
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,constant: 120),
            emailTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20)])
    }
    private func setPasswordTextFieldConstraints() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor,constant: 50),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)])
    }
    private func setLogInButtonConstraints() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor,constant: 70),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    private func setSignInButtonConstraints() {
        view.addSubview(createAccountButton)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            createAccountButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -40)])
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogInUI()

    }
    

}
