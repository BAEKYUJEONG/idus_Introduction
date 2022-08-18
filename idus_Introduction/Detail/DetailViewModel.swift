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
    
    func getTitle() -> String {
        return detailData?.detailResult[0].trackName ?? "아이디어스(idus)"
    }
    
    func getArtistName() -> String {
        return detailData?.detailResult[0].artistName ?? "Backpackr Inc."
    }
    
    func getDescription() -> String {
        return detailData?.detailResult[0].description ?? "Description"
    }
    
    func getScreenShot() -> [String] {
        let screenshotArr = detailData?.detailResult[0].screenshotUrls ?? []
        self.screenshotArr = screenshotArr
        return screenshotArr
    }
    
    func fetchScreenShot(_ indexPath: IndexPath, _ completion: @escaping (UIImage) -> Void) {
        let screenshotArr: [String] = getScreenShot()
        
        LoadImage().loadImage(screenshotArr[indexPath.row]) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func screenShotCount() -> Int {
        return detailData!.detailResult[0].screenshotUrls.count
    }
}
