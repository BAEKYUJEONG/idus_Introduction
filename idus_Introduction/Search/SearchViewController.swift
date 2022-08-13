//
//  SearchViewController.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/13.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var viewModel = SearchViewModel()
    private var iconImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .yellow
        return image
    }()
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "아이디를 입력해주세요."
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
        bind(viewModel)
    }
}

extension SearchViewController {
    private func attribute() {
        searchBar.delegate = self
    }
    
    private func layout() {
        view.backgroundColor = .white
        
        [
            iconImage,
            searchBar
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -50),
            iconImage.widthAnchor.constraint(equalToConstant: 100),
            iconImage.heightAnchor.constraint(equalToConstant: 100),
            
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func bind(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let id = searchBar.text {
            viewModel.getDetail(id) { result in
                switch result {
                case .success(let detail):
                    print(detail)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
