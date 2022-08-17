//
//  PriviewCollectionViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/16.
//

import UIKit

protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
}

class PriviewCollectionViewCell: UICollectionViewCell, ReusableCell {
    
    private let priviewImage = UIImageView()
    
    func setup(_ indexPath: IndexPath, _ screenshotArr: [String]?) {
        layout()
        loadImage(indexPath, screenshotArr ?? [])
    }
    
    private func loadImage(_ indexPath: IndexPath, _ screenshotArr: [String]) {
        LoadImage().loadImage(screenshotArr[indexPath.row]) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.priviewImage.image = image
                    print("here", screenshotArr[indexPath.row])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension PriviewCollectionViewCell {
    func layout() {
        priviewImage.isUserInteractionEnabled = false
        
        [
            priviewImage
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            priviewImage.topAnchor.constraint(equalTo: self.topAnchor),
            priviewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priviewImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            priviewImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
