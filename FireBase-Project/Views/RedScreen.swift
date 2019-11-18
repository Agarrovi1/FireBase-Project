//
//  RedScreen.swift
//  FireBase-Project
//
//  Created by Angela Garrovillas on 11/18/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
import UIKit

class RedScreen: UIView {
    private var outerCircle: UIView = {
        let view = UIView()
        var frame = view.frame.size
        frame.height = 200
        frame.width = frame.height
        view.frame.size = frame
        view.backgroundColor = #colorLiteral(red: 0.897580564, green: 0.09738414735, blue: 0.2803892195, alpha: 1)
        view.layer.cornerRadius = view.frame.height / 2
        return view
    }()
    private var middleCircle: UIView = {
        let view = UIView()
        var frame = view.frame.size
        frame.height = 170
        frame.width = frame.height
        view.frame.size = frame
        view.backgroundColor = #colorLiteral(red: 0.9040751457, green: 0.1900836229, blue: 0.353982687, alpha: 1)
        view.layer.cornerRadius = view.frame.height / 2
        return view
    }()
    private var innerCircle: UIView = {
        let view = UIView()
        var frame = view.frame.size
        frame.height = 140
        frame.width = frame.height
        view.frame.size = frame
        view.backgroundColor = #colorLiteral(red: 0.9178534746, green: 0.2777439952, blue: 0.4114097655, alpha: 1)
        view.layer.cornerRadius = view.frame.height / 2
        return view
    }()
    private var imageCircle: UIImageView = {
        let view = UIImageView()
        var frame = view.frame.size
        frame.height = 110
        frame.width = frame.height
        view.frame.size = frame
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        view.layer.cornerRadius = view.frame.height / 2
        return view
    }()
    
    
    func setupView() {
        self.backgroundColor = #colorLiteral(red: 0.8773084879, green: 0, blue: 0.1880673468, alpha: 1)
        setupOuterCircle()
        setupMiddleCircle()
        setupInnerCircle()
        setupImageCircle()
    }
    func setupOuterCircle() {
        self.addSubview(outerCircle)
        outerCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            outerCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            outerCircle.heightAnchor.constraint(equalToConstant: outerCircle.frame.height),
        outerCircle.widthAnchor.constraint(equalToConstant: outerCircle.frame.width)])
    }
    func setupMiddleCircle() {
        self.addSubview(middleCircle)
        middleCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        middleCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        middleCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        middleCircle.heightAnchor.constraint(equalToConstant: middleCircle.frame.height),
        middleCircle.widthAnchor.constraint(equalToConstant: middleCircle.frame.width)])
    }
    func setupInnerCircle() {
        self.addSubview(innerCircle)
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        innerCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        innerCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        innerCircle.heightAnchor.constraint(equalToConstant: innerCircle.frame.height),
        innerCircle.widthAnchor.constraint(equalToConstant: innerCircle.frame.width)])
    }
    func setupImageCircle() {
        addSubview(imageCircle)
        imageCircle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        imageCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
        imageCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
        imageCircle.heightAnchor.constraint(equalToConstant: imageCircle.frame.height),
        imageCircle.widthAnchor.constraint(equalToConstant: imageCircle.frame.width)])
    }

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.8899938464, green: 0, blue: 0.191550523, alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
