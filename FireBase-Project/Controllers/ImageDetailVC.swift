//
//  ImageDetailVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class ImageDetailVC: UIViewController {
    //MARK: - UI Objects
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "Image Detail"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var detailImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    var submitLabel: UILabel = {
        let label = UILabel()
        label.text = "Submitted by:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    var createdLabel: UILabel = {
        let label = UILabel()
        label.text = "Created at: MM/DD HH:MM"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    //MARK: - Constraints
    private func setDetailUI() {
        setDetailLabelConstraints()
        setDetailImageConstraints()
        setSubmitLabelConstraints()
        setCreatedLabelConstraints()
    }
    private func setDetailLabelConstraints() {
        view.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            detailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    }
    private func setDetailImageConstraints() {
        view.addSubview(detailImageView)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor,constant: 25),
            detailImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            detailImageView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            detailImageView.heightAnchor.constraint(equalToConstant: view.bounds.width)])
    }
    private func setSubmitLabelConstraints() {
        view.addSubview(submitLabel)
        submitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 20),
            submitLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            submitLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
    }
    private func setCreatedLabelConstraints() {
        view.addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createdLabel.topAnchor.constraint(equalTo: submitLabel.bottomAnchor, constant: 20),
            createdLabel.leadingAnchor.constraint(equalTo: submitLabel.leadingAnchor),
            createdLabel.trailingAnchor.constraint(equalTo: submitLabel.trailingAnchor)])
    }
    
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        setDetailUI()

    }
    

}
