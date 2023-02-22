//
//  AppGroup.swift
//  AppStore
//
//  Created by Kirill Karpovich on 22.02.23.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
