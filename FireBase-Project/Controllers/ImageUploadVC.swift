//
//  ImageUploadVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ImageUploadVC: UIViewController {
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
        return button
    }()
    
    //MARK: - Constraints
    private func setUploadUI() {
        setUploadLabelConstraints()
        setUploadImageConstraints()
        setUploadButtonConstraints()
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
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        setUploadUI()
    }

}
