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
    
    private var appView: UIView = {
        var uiView = UIView()
        uiView.backgroundColor = .brown
        return uiView
    }()
    
    private var appImage: UIImageView = {
        var imageView = UIImageView()
        return imageView
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
        
        initialize()
        attribute()
        layout()
        setIconImage()
    }
    
    func getViewModelData(_ detail: Detail) {
        viewModel.getDetailData(detail)
    }
}

extension DetailViewController {
    
    private func initialize() {
        contentStackView = ContentStackView(viewModel)
    }

    private func attribute() {
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        previewCollectionView.register(cellType: PreviewCollectionViewCell.self)
    }
    
    private func layout() {
        contentScrollView.isUserInteractionEnabled = false
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(appView)
        contentStackView.addArrangedSubview(previewCollectionView)
        
        appView.addSubview(appImage)
        
        [
            contentScrollView,
            contentStackView,
            previewCollectionView,
            appImage
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
            
            appView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            appView.heightAnchor.constraint(equalToConstant: 140),

            previewCollectionView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            previewCollectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    private func setIconImage() {
        LoadImage().loadImage("https://is5-ssl.mzstatic.com/image/thumb/Purple112/v4/f9/6e/ed/f96eed72-72d6-4354-97fa-ee649c21832d/AppIcon-1x_U007emarketing-0-6-0-sRGB-85-220.png/100x100bb.jpg") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.appImage.image = image
                }
            case .failure(_):
                print("fail")
            }
        }
        self.viewModel.imageSucceed = { image in
            self.appImage.image = image
        }
        
        appImage.layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            appImage.topAnchor.constraint(equalTo: appView.topAnchor, constant: 10),
            appImage.leadingAnchor.constraint(equalTo: appView.leadingAnchor, constant: 10),
            appImage.bottomAnchor.constraint(equalTo: appView.bottomAnchor, constant: 10),
            appImage.heightAnchor.constraint(equalTo: appImage.widthAnchor)
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
