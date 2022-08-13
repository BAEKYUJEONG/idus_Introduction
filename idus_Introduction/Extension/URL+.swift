//
//  URL+.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/13.
//

import Foundation

extension URL {
    static let baseURL = "http://itunes.apple.com/lookup"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}
