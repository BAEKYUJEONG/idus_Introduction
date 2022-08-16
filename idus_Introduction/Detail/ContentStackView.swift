//
//  ContentStackView.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/15.
//

import UIKit

class ContentStackView: UIStackView {
    
    private var appView = UIView()
    private var newFuncView = UIView()
    private var previewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    private var descriptionView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        configureProperties()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProperties() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 0
    }
    
    
    private func attribute() {
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
        previewCollectionView.register(cellType: PriviewCollectionViewCell.self)
    }
    
    private func layout() {
        appView.backgroundColor = .yellow
        [
            appView,
            newFuncView,
            previewCollectionView,
            descriptionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
}

extension ContentStackView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /// priview 갯수를 받아서 할 지 고정값이니 고정 값을 넣을 지
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = previewCollectionView.dequeueReusableCell(cellType: PriviewCollectionViewCell.self, indexPath: indexPath)
        
        cell.setup()
        
        return cell
    }
}
