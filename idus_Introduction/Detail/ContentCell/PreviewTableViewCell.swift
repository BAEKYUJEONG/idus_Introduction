//
//  PreviewTableViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/17.
//

import UIKit

protocol ModalDelegate: AnyObject {
    func presentModal(_ vc: UIViewController)
}

class PreviewTableViewCell: UITableViewCell {
    
    weak var delegate: ModalDelegate?
    private var viewModel = DetailViewModel()
    private var previewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 500)
        layout.scrollDirection = .horizontal
        
        let collectView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectView
    }()
    
    func setup(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        attribute()
        layout()
    }
}

extension PreviewTableViewCell {
    
    private func attribute() {
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        previewCollectionView.register(cellType: PreviewCollectionViewCell.self)
    }
    
    private func layout() {
        [
            previewCollectionView
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            previewCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            previewCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previewCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            previewCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension PreviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.screenShotCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = previewCollectionView.dequeueReusableCell(cellType: PreviewCollectionViewCell.self, indexPath: indexPath)
        cell.setup(indexPath, viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PreviewModalViewController()
        vc.fetchImage(indexPath, viewModel)
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        delegate?.presentModal(vc)
    }
}
