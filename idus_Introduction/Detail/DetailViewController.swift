//
//  DetailViewController.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/14.
//

import UIKit

class DetailViewController: UIViewController {

    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    private let contentView = UIView()
    private let contentStackView = ContentStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
}

extension DetailViewController {
    
    private func layout() {
        view.backgroundColor = .brown
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        
        [
            contentScrollView,
            contentView,
            contentStackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
        ])
    }
}
