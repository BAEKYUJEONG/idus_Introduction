//
//  EndPoint.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/13.
//

import Foundation

enum EndPoint {
    case getDetail(Int)
}

extension EndPoint {
    var url: URL {
        switch self {
        case .getDetail(let id):
            return .makeEndPoint("?id=\(id)")
        }
    }
}
