//
//  FeedCell.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    var feedImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        image.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        image.contentMode = .scaleAspectFill
        return image
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    func setImageConstraints() {
        contentView.addSubview(feedImage)
        feedImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            feedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            feedImage.widthAnchor.constraint(equalToConstant: feedImage.frame.width),
            feedImage.heightAnchor.constraint(equalToConstant: feedImage.frame.height)])
    }
    func setNameConstraints() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: feedImage.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageConstraints()
        setNameConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
