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
        HStack {
            if let urlString = song.artworkUrl100, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }

            VStack(alignment: .leading) {
                Text(song.artistName ?? "")
                Text(song.trackName ?? "")
                Text(song.collectionName ?? "")
            }
        }
    }
}


struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: Song(artistName: "Artist", trackName: "trackName", collectionName: "collectionName", kind: "kind", wrapperType: "wrapperType", artworkUrl100: "artworkUrl100"))
    }
}
