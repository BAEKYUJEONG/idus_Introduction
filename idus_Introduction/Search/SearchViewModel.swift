//
//  SearchViewModel.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/13.
//

import UIKit

final class SearchViewModel {
    
    private let detailAPIService = DetailAPIService()
    
    func getDetail(_ id: Int, _ completion: @escaping (Result<Detail, APIError>) -> Void) {
        detailAPIService.getDetail(id, completion)
    }
}
