//
//  ProfileVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - UI Objects
    var profileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "Profile"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var displayNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "Display Name"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "example@email.com"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    var imageSubmissionLabel: UILabel = {
        let label = UILabel()
        label.text = "You have submitted 0 images"
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        return button
    }()
    var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        return button
    }()
    
    
    //MARK: - Constraints
    private func setupProfileUI() {
        setProfileLabelConstraints()
        setImageConstraints()
        setDisplayNameConstraints()
        setEditButtonConstraints()
        setEmailLabelConstraints()
        setSubmissionConstraints()
        setAddButtonConstraints()
    }
    private func setProfileLabelConstraints() {
        view.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            profileLabel.heightAnchor.constraint(equalToConstant: 70),
            profileLabel.widthAnchor.constraint(equalToConstant: 200)])
    }
    private func setImageConstraints() {
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: profileLabel.centerXAnchor),
            profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            profileImage.heightAnchor.constraint(equalToConstant: 200)])
    }
    private func setDisplayNameConstraints() {
        view.addSubview(displayNameLabel)
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor,constant: 20),
            displayNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            displayNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20)])
    }
    private func setEditButtonConstraints() {
        view.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor),
            editButton.centerXAnchor.constraint(equalTo: displayNameLabel.centerXAnchor)])
    }
    private func setEmailLabelConstraints() {
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 50),
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    }
    private func setSubmissionConstraints() {
        view.addSubview(imageSubmissionLabel)
        imageSubmissionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageSubmissionLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            imageSubmissionLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            imageSubmissionLabel.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor)])
    }
    private func setAddButtonConstraints() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: profileImage.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50)])
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        setupProfileUI()

    }
    

}
