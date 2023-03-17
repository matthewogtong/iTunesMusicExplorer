//
//  SongRow.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import SwiftUI

struct SongRow: View {

    let song: Song

    var body: some View {
        VStack {
            Text(song.artistName ?? "")
            Text(song.collectionName ?? "")
            Text(song.kind ?? "")
            Text(song.trackName ?? "")
            Text(song.artworkUrl100 ?? "")
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: Song(artistName: "Artist", trackName: "trackName", collectionName: "collectionName", kind: "kind", artworkUrl100: "artworkUrl100"))
    }
}
