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
    
    private let sections: [String] = ["아이디어스", "새로운 기능", "미리보기", "설명"]
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
    
//    private func setIconImage() {
//        LoadImage().loadImage("https://is5-ssl.mzstatic.com/image/thumb/Purple112/v4/f9/6e/ed/f96eed72-72d6-4354-97fa-ee649c21832d/AppIcon-1x_U007emarketing-0-6-0-sRGB-85-220.png/100x100bb.jpg") { result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self.appImage.image = image
//                }
//            case .failure(_):
//                print("fail")
//            }
//        }
//        self.viewModel.imageSucceed = { image in
//            self.appImage.image = image
//        }
//
//        NSLayoutConstraint.activate([
//            appImage.topAnchor.constraint(equalTo: appView.topAnchor, constant: 10),
//            appImage.leadingAnchor.constraint(equalTo: appView.leadingAnchor, constant: 10),
//            appImage.bottomAnchor.constraint(equalTo: appView.bottomAnchor, constant: 10),
//            appImage.heightAnchor.constraint(equalTo: appImage.widthAnchor)
//        ])
//    }
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
        } else if indexPath.section == 2 {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "preview", for: indexPath) as! PreviewTableViewCell
            cell.setup(viewModel)
            return cell
        } else {
            let cell = contentTableView.dequeueReusableCell(withIdentifier: "description", for: indexPath) as! DescriptionTableViewCell
            cell.setup(viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 500
        } else if indexPath.section == 3 {
            return 500
        } else {
            return 100
        }
    }
}
