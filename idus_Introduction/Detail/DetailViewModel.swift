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
    
    func getAppIconImage(_ completion: @escaping (UIImage) -> Void) {
        let iconString = detailData!.detailResult[0].artworkUrl100
        
        LoadImage().loadImage(iconString) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(_):
                let image = UIImage(systemName: "x.square")!
                completion(image)
            }
        }
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
