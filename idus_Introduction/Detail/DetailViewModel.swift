//
//  DetailViewModel.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/16.
//

import UIKit

class DetailViewModel {
    
    private var detailData: Detail?
    private var screenshotArr: [String] = []
    
    func getDetailData(_ detail: Detail) {
        detailData = detail
        print(detailData)
    }
    
    func getScreenShot() -> [String]? {
        let screenshotArr = detailData?.detailResult[0].screenshotUrls ?? []
        self.screenshotArr = screenshotArr
        print(#function)
        return screenshotArr
    }
    
    func screenShotCount() -> Int {
        return detailData!.detailResult[0].screenshotUrls.count
    }
}
