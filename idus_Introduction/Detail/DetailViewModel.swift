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
    var imageSucceed: (_ image: UIImage) -> () = { image in }
    
    func getDetailData(_ detail: Detail) {
        detailData = detail
        print(detailData)
    }
    
    func getAppIconImage() -> UIImage {
        let iconString = detailData!.detailResult[0].artworkUrl100
        var iconImage = UIImage()
        
        LoadImage().loadImage(iconString) { result in
            switch result {
            case .success(let image):
                iconImage = image
                self.imageSucceed(image)
            case .failure(_):
                iconImage = UIImage(systemName: "x.square")!
            }
        }
        return iconImage
    }
    
    func getDescription() -> String {
        return detailData?.detailResult[0].description ?? "text"
    }
    
    func getScreenShot() -> [String]? {
        let screenshotArr = detailData?.detailResult[0].screenshotUrls ?? []
        self.screenshotArr = screenshotArr
        return screenshotArr
    }
    
    func screenShotCount() -> Int {
        return detailData!.detailResult[0].screenshotUrls.count
    }
}
