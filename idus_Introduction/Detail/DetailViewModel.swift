//
//  DetailViewModel.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/16.
//

import UIKit

class DetailViewModel {
    
    private var detailData: Detail?
    
    func getDetailData(_ detail: Detail) {
        detailData = detail
        print(detailData)
    }
}
