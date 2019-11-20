//
//  ImageUploadVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit
import Photos

class ImageUploadVC: UIViewController {
    //MARK: - Properties
    var image = UIImage() {
        didSet {
            self.uploadImageView.image = image
        }
    }
    var imageURL: URL? = nil
    
    //MARK: - UI Objects
    var uploadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "Upload an Image"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var uploadImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        return button
    }()
    var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Constraints
    private func setUploadUI() {
        setUploadLabelConstraints()
        setUploadImageConstraints()
        setUploadButtonConstraints()
        setAddButtonConstraints()
    }
    private func setUploadLabelConstraints() {
        view.addSubview(uploadLabel)
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uploadLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            uploadLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uploadLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    }
    private func setUploadImageConstraints() {
        view.addSubview(uploadImageView)
        uploadImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uploadImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            uploadImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            uploadImageView.widthAnchor.constraint(equalToConstant: 200),
            uploadImageView.heightAnchor.constraint(equalToConstant: 200)])
    }
    private func setUploadButtonConstraints() {
        view.addSubview(uploadButton)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uploadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            uploadButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)])
    }
    private func setAddButtonConstraints() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: uploadImageView.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: uploadImageView.trailingAnchor,constant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    //MARK: - Properties
    private func presentPhotoPickerController() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }
    private func makeAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: - Objc Func
    @objc func addButtonTapped() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized:
                    self?.presentPhotoPickerController()
                case .denied:
                    //MARK: TODO - set up more intuitive UI interaction
                    print("Denied photo library permissions")
                default:
                    //MARK: TODO - set up more intuitive UI interaction
                    print("No usable status")
                }
            })
        default:
            presentPhotoPickerController()
        }
    }
    @objc func uploadButtonTapped() {
        guard let user = FirebaseAuthService.manager.currentUser else {return}
        guard let photoUrl = imageURL?.absoluteString else {return}
        FirestoreService.manager.createPost(post: Post(photoUrl: photoUrl, creatorID: user.uid)) { (result) in
            switch result {
            case .failure(let error):
                self.makeAlert(with: "Could not make post", and: "Error: \(error)")
            case .success:
                self.makeAlert(with: "Yay", and: "Post created")
            }
        }
    }
    
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        setUploadUI()
    }

}

extension ImageUploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
        FirebaseStorageService.uploadManager.storeImage(image: imageData, completion: { [weak self] (result) in
            switch result{
            case .success(let url):
                self?.imageURL = url
                
            case .failure(let error):
                print(error)
            }
        })
        dismiss(animated: true, completion: nil)
    }
}
