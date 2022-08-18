//
//  Detail.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/13.
//

import Foundation

struct Detail: Decodable {
    let detailResult: [Results]

    enum CodingKeys: String, CodingKey {
        case detailResult = "results"
    }
}

struct Results: Decodable {
    let artworkUrl100: String
    let trackName: String
    let artistName: String
    
    let version: String
    let releaseNotes: String
    
    let screenshotUrls: [String]
    let description: String
}
