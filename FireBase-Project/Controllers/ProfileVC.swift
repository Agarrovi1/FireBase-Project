//
//  ProfileVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - Properties
    var image = UIImage() {
        didSet {
            self.profileImage.image = image
        }
    }
    var imageURL: String? = nil
    var postCount = 0 {
        didSet {
            imageSubmissionLabel.text = "You have submitted \(postCount) images"
        }
    }
    
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
        button.addTarget(self, action: #selector(displayForm), for: .touchUpInside)
        return button
    }()
    var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.addTarget(self, action: #selector(presentPhotoPickerController), for: .touchUpInside)
        return button
    }()
    var displayNameTextBox: UITextField?
    
    
    //MARK: - Constraints
    private func setupProfileUI() {
        setProfileLabelConstraints()
        setImageConstraints()
        setDisplayNameConstraints()
        setEditButtonConstraints()
        setEmailLabelConstraints()
        setSubmissionConstraints()
        setAddButtonConstraints()
        setupEmailLabel()
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
    
    //MARK: - Setup Method
    private func setupEmailLabel() {
        if let email = FirebaseAuthService.manager.currentUser?.email {
            emailLabel.text = "\(email)"
        }
    }
    //MARK: - Private Methods
    private func makeAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func setDefaultName() {
        if let displayName = FirebaseAuthService.manager.currentUser?.displayName {
            displayNameLabel.text = displayName
        }
    }
    private func setDefaultImage() {
        if let pictureUrl = FirebaseAuthService.manager.currentUser?.photoURL {
            FirebaseStorageService.profileManager.getUserImage(photoUrl: pictureUrl) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.profileImage.image = image
                }
            }
        }
    }
    private func getPostCount() {
        if let userUID = FirebaseAuthService.manager.currentUser?.uid {
        DispatchQueue.global(qos: .default).async {
            FirestoreService.manager.getPosts(forUserID: userUID) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let posts):
                    self.postCount = posts.count
                }
            }
        }
        }
    }
    private func updateUserNameField(newDisplayName: String) {
        guard let userUID = FirebaseAuthService.manager.currentUser?.uid else {
            return
        }
        FirestoreService.manager.updateAppUser(id: userUID, newDisplayName: newDisplayName) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success:
                print("updated users in FireStore")
            }
        }
    }
    
    //MARK: - Objc Functions
    @objc func displayForm(){
        //create alert
        let alert = UIAlertController(title: "Edit Display Name?", message: nil, preferredStyle: .alert)
        
        //create cancel button
        let cancelAction = UIAlertAction(title: "Cancel" , style: .cancel)
        
        //create save button
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) -> Void in
            
            guard let newName = self.displayNameTextBox?.text, !newName.isEmpty else {
                self.makeAlert(with: "Required", and: "Fill both fields")
                return
            }
            
            FirebaseAuthService.manager.updateUserFields(userName: newName) { (result) in
                switch result {
                case .success:
                    self.makeAlert(with: "Display Name Changed!", and: "Yay")
                    self.displayNameLabel.text = newName
                    self.updateUserNameField(newDisplayName: newName)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter New Display Name"
            self.displayNameTextBox = textField
        })
        self.present(alert, animated: true, completion: nil)
    }
    @objc func presentPhotoPickerController() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        setupProfileUI()
        setDefaultName()
        setDefaultImage()
        getPostCount()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDefaultName()
        setDefaultImage()
        getPostCount()
    }
    

}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            //MARK: TODO - handle couldn't get image :(
            makeAlert(with: "Error", and: "Couldn't get image")
            return
        }
        self.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            //MARK: TODO - gracefully fail out without interrupting UX
            makeAlert(with: "Error", and: "could not compress image")
            return
        }
        
        FirebaseStorageService.profileManager.storeImage(image: imageData, completion: { [weak self] (result) in
            switch result{
            case .success(let url):
                self?.imageURL = url
                FirebaseAuthService.manager.updateUserFields(userName: nil, photoURL: url) { (_) in
                    
                }
                
            case .failure(let error):
                print(error)
            }
        })
        dismiss(animated: true, completion: nil)
    }
}
