//
//  FeedVC.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    //MARK: - Properties
    var posts = [Post]() {
        didSet {
            self.feedCollectionView.reloadData()
        }
    }
    
    //MARK: - UI Object
    var feedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "Feed"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    var feedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 160, height: 160)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.register(FeedCell.self, forCellWithReuseIdentifier: "feedCell")
        return collection
    }()
    
    //MARK: - Constraints
    private func setFeedUI() {
        setFeedLabelConstraints()
        setCollectionViewConstraints()
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
    }
    private func setFeedLabelConstraints() {
        view.addSubview(feedLabel)
        feedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            feedLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            feedLabel.heightAnchor.constraint(equalToConstant: 70),
            feedLabel.widthAnchor.constraint(equalToConstant: 200)])
    }
    private func setCollectionViewConstraints() {
        view.addSubview(feedCollectionView)
        feedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedCollectionView.topAnchor.constraint(equalTo: feedLabel.bottomAnchor, constant: 40),
            feedCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            feedCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            feedCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    //MARK: - Private Functions
    private func getPosts() {
        FirestoreService.manager.getAllPosts(sortingCriteria: nil) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let postsFromFirebase):
                DispatchQueue.main.async {
                    self.posts = postsFromFirebase
                }
            }
        }
    }

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        setFeedUI()
        getPosts()

    }
}

extension FeedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            return UICollectionViewCell()
        }
        let post = posts[indexPath.row]
        DispatchQueue.main.async {
            if let photoUrl = post.photoUrl {
                ImageHelper.shared.fetchImage(urlString: photoUrl) { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                        cell.feedImage.image = UIImage(named: "noImage")
                    case .success(let imageFromFirebase):
                            cell.feedImage.image = imageFromFirebase
                    }
                }
            }
        }
        return cell
    }
    
    
}
