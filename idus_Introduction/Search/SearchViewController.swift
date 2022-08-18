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
        let imageView = UIImageView()
        imageView.image = UIImage(named: "idus_icon")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
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
        dataBinding()
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
    
    private func dataBinding() {
        self.viewModel.loadingSucceed = { [weak self] in
            DispatchQueue.main.async {
                let vc = DetailViewController()
                guard let self = self else { return }
                guard let detail = self.viewModel.passDetailData() else { return }
                vc.getViewModelData(detail)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        self.viewModel.loadingFailed = { [weak self] error in
            guard let self = self else { return }
            self.alert(title: "로딩 실패", message: "로딩에 실패하였습니다.")
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        if let id = searchBar.text {
            if id != "872469884" {
                self.alert(title: "아이디 오류", message: "아이디가 잘못되었습니다.")
            } else {
                viewModel.getDetail(id)
            }
            
        }
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}
