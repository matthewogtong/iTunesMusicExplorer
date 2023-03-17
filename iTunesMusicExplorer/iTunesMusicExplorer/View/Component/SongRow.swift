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
            if let urlString = song.artworkUrl100, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: Song(artistName: "Artist", trackName: "trackName", collectionName: "collectionName", kind: "kind", wrapperType: "wrapperType", artworkUrl100: "artworkUrl100"))
    }
}
