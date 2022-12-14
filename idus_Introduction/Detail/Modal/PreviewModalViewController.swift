//
//  PreviewModalViewController.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/18.
//

import UIKit

class PreviewModalViewController: UIViewController {
    
    weak var delegate: ModalDelegate?
    var previewImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        setupDismissModal()
    }
    
    func fetchImage(_ indexPath: IndexPath, _ viewModel: DetailViewModel) {
        viewModel.fetchScreenShot(indexPath) { image in
            self.previewImage.image = image
        }
    }
    
    func setupDismissModal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
        self.previewImage.addGestureRecognizer(tapGesture)
        previewImage.isUserInteractionEnabled = true
    }
    
    @objc func dismissModal() {
        self.dismiss(animated: true)
    }
}

extension PreviewModalViewController {
    
    private func layout() {
        [
            previewImage
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            previewImage.topAnchor.constraint(equalTo: view.topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
