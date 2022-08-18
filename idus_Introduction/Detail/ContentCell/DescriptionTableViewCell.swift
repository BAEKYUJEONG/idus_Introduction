//
//  DescriptionTableViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/17.
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

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
}

class DescriptionTableViewCell: UITableViewCell, ReusableCell {
    
    private var descriptionTextView = UITextView()
    
    func setup(_ viewModel: DetailViewModel) {
        descriptionTextView.text = viewModel.getDescription()
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        
        layout()
    }
}

extension DescriptionTableViewCell {
    
    private func layout() {
        [
            descriptionTextView
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: inset)
        ])
    }
}
