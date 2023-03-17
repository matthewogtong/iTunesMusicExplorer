//
//  Song.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import Foundation

struct InitialResponse: Codable {
    var resultCount: Int
    var results: [Song]
}

struct Song: Codable, Identifiable {
    var id: String {" \(String(describing: artistName)) + \(artworkUrl100 ?? "")"}
    let artistName: String?
    let trackName: String?
    let collectionName: String?
    let kind: String?
    let wrapperType: String?
    let artworkUrl100: String?
}
