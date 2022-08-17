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
    
    private var contentStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private var previewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 250, height: 400)
        layout.scrollDirection = .horizontal
        
        let collectView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        initialize()
        attribute()
        layout()
    }
    
    func getViewModelData(_ detail: Detail) {
        viewModel.getDetailData(detail)
    }
}

extension DetailViewController {
    
//    private func initialize() {
//        contentStackView = ContentStackView(viewModel)
//    }

    private func attribute() {
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        previewCollectionView.register(cellType: PreviewCollectionViewCell.self)
    }
    
    private func layout() {
        contentScrollView.isUserInteractionEnabled = false
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(previewCollectionView)
        
        [
            contentScrollView,
            contentStackView,
            previewCollectionView
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
            contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            
            previewCollectionView.widthAnchor.constraint(equalToConstant: 300),
            previewCollectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.screenShotCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = previewCollectionView.dequeueReusableCell(cellType: PreviewCollectionViewCell.self, indexPath: indexPath)
        
        cell.setup(indexPath, viewModel.getScreenShot())
        
        return cell
    }
}
