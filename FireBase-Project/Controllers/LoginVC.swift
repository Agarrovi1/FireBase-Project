//
//  LoginVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        textField.addTarget(self, action: #selector(tryLogIn), for: .primaryActionTriggered)
        return textField
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 14)
        button.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(tryLogIn), for: .touchUpInside)
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
                button.addTarget(self, action: #selector(displayForm), for: .touchUpInside)
        return button
    }()
    
    var signInEmail: UITextField?
    var signInPassword: UITextField?
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
    //MARK: - Functions
    
    private func makeAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    //MARK: Handling SignIn
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let user):
                FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                    self?.handleCreatedUserInFirestore(result: newResult)
                }
            case .failure(let error):
                self?.makeAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
            }
        }
    }
    private func handleCreatedUserInFirestore(result: Result<(), Error>) {
        switch result {
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    return
            }
            
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser?.photoURL != nil {
                    window.rootViewController = {
                        let profileSetupVC = FirebaseTabBar()
                            profileSetupVC.selectedIndex = 3
                        return profileSetupVC
                    }()
                } else {
                    window.rootViewController = {
                        let feedSetupVC = FirebaseTabBar()
                        feedSetupVC.selectedIndex = 0
                        return feedSetupVC
                    }()
                }
            }, completion: nil)
        case .failure(let error):
            self.makeAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
        }
    }
    //MARK: Handling Login
    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            makeAlert(with: "Error", and: "Could not log in. Error: \(error)")
        case .success:
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    return
            }
            
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser?.photoURL != nil {
                    window.rootViewController = {
                        let profileSetupVC = FirebaseTabBar()
                            profileSetupVC.selectedIndex = 3
                        return profileSetupVC
                    }()
                } else {
                    window.rootViewController = {
                        let feedSetupVC = FirebaseTabBar()
                        feedSetupVC.selectedIndex = 0
                        return feedSetupVC
                    }()
                }
            }, completion: nil)
        }
    }
    
    //MARK: - Objc Func
    @objc func tryLogIn() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            makeAlert(with: "Required", and: "Fill both fields")
            return
        }
        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
            self.handleLoginResponse(with: result)
        }
    }
    @objc func displayForm(){
        let alert = UIAlertController(title: "Sign In", message: "Create an account", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel" , style: .cancel)
        
        let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) -> Void in
            
            guard let email = self.signInEmail?.text, !email.isEmpty, let password = self.signInPassword?.text, !password.isEmpty else {
                self.makeAlert(with: "Required", and: "Fill both fields")
                return
            }
            FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { (result) in
                switch result {
                case .failure(let error):
                    self.makeAlert(with: "Couldn't create user", and: "Error: \(error)")
                case .success(let newUser):
                    FirestoreService.manager.createAppUser(user: AppUser.init(from: newUser)) { (result) in
                        self.handleLoginResponse(with: result)
                    }
                    
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter email address"
            self.signInEmail = textField
        })
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter password"
            textField.isSecureTextEntry = true
            self.signInPassword = textField
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogInUI()

    }
    

}
