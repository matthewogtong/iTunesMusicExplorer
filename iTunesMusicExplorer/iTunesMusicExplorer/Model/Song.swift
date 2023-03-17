//
//  Song.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import Foundation

// artistName, trackName, collectionName, kind, artworkUrl100

struct InitialResponse: Codable {
    var resultCount: Int
    var results: [Song]
}

struct Song: Codable, Identifiable {
    var id: String {" \(artistName) + \(artworkUrl100)"}
    let artistName: String?
    var trackName: String?
    let collectionName: String?
    let kind: String?
    let artworkUrl100: String?
}
