//
//  DetailAPIService.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/13.
//

import UIKit

enum APIError: Error {
    case unexpectedStatusCode(statusCode: String)
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class DetailAPIService {
    
    func getDetail(_ id: String, _ completion: @escaping (Result<Detail, APIError>) -> Void) {
        let request = URLRequest(url: EndPoint.getDetail(id).url)
        URLSession.request(.shared, endpoint: request, completion: completion)
    }
}
