//
//  DetailViewController.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/14.
//

import UIKit

// id: 872469884
class DetailViewController: UIViewController {

    var viewModel = DetailViewModel()
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var contentStackView = ContentStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        layout()
    }
    
    func getViewModelData(_ detail: Detail) {
        viewModel.getDetailData(detail)
    }
}

extension DetailViewController {
    
    private func initialize() {
        contentStackView = ContentStackView(viewModel)
    }

    private func layout() {
        contentScrollView.contentSize = CGSize(width: view.frame.size.width, height: 15000)
        contentScrollView.isUserInteractionEnabled = false
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackView)
        
        [
            contentScrollView,
            contentStackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor)
        ])
    }
}
