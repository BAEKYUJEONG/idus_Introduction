//
//  DetailViewController.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/14.
//

import UIKit

class DetailViewController: UIViewController{

    var viewModel = DetailViewModel()
    
    private var textViewHeight: CGFloat = 0
    private let sections: [String] = ["아이디어스", "새로운 기능", "설명", "미리보기"]
    private var contentTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func getViewModelData(_ detail: Detail) {
        viewModel.getDetailData(detail)
    }
}

extension DetailViewController {
    
    private func attribute() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(TitleTableViewCell.self, forCellReuseIdentifier: "title")
        contentTableView.register(NewFuncTableViewCell.self, forCellReuseIdentifier: "newFunc")
        contentTableView.register(PreviewTableViewCell.self, forCellReuseIdentifier: "preview")
        contentTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "description")
    }
    
    private func layout() {
        [
            contentTableView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: view.topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleTableViewCell
            cell.setup(viewModel)
            return cell
        } else if indexPath.section == 1 {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "newFunc", for: indexPath) as! NewFuncTableViewCell
            cell.setup(viewModel)
            return cell
        } else if indexPath.section == 2 {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "description", for: indexPath) as! DescriptionTableViewCell
            cell.setup(viewModel)
            cell.delegate = self
            return cell
        } else {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "preview", for: indexPath) as! PreviewTableViewCell
            cell.setup(viewModel)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else if indexPath.section == 1 {
            return 120
        } else if indexPath.section == 2 {
            return 500
        } else {
            return 500
        }
    }
}

extension DetailViewController: FoldableDelegate {
    
    func setTextViewHeight(height: CGFloat) {
        textViewHeight = height
    }
}

extension DetailViewController: ModalDelegate {
    
    func presentModal(_ vc: UIViewController) {
        self.present(vc, animated: true)
    }
}
