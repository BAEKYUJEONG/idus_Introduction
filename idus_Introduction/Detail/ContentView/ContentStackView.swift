//
//  ContentStackView.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/15.
//

import UIKit

class ContentStackView: UIStackView {
    
    private var viewModel = DetailViewModel()
    
    private var appView = UIView()
    private var newFuncView = UIView()
    private var previewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 250, height: 400)
        layout.scrollDirection = .horizontal
        
        let collectView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectView
    }()
    private var descriptionView = DescriptionView()
    private var descriptionTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: DetailViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        configureProperties()
        initialize()
        attribute()
        layout()
    }
    
    private func configureProperties() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.alignment = .center
        self.spacing = 0
    }
    
    private func initialize() {
        descriptionView = DescriptionView(viewModel)
    }
    
    private func attribute() {
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        previewCollectionView.register(cellType: PreviewCollectionViewCell.self)
    }
    
    private func layout() {
        [
            appView,
            newFuncView,
            previewCollectionView,
            descriptionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            previewCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            previewCollectionView.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            descriptionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension ContentStackView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.screenShotCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = previewCollectionView.dequeueReusableCell(cellType: PreviewCollectionViewCell.self, indexPath: indexPath)
        
        cell.setup(indexPath, viewModel.getScreenShot())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
