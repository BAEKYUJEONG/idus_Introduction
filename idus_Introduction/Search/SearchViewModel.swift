//
//  SearchViewModel.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/13.
//

import UIKit

final class SearchViewModel {
    
    private let detailAPIService = DetailAPIService()
    private var detailData: Detail?
    var loadingSucceed: () -> () = {}
    var loadingFailed: (_ error: APIError) -> () = { error in }
    
    func getDetail(_ id: String) {
        detailAPIService.getDetail(id) { result in
            switch result {
            case .success(let detail):
                self.detailData = detail
                self.loadingSucceed()
            case .failure(let error):
                self.loadingFailed(error)
            }
        }
    }
    
}
