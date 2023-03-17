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
            AsyncImage(url: URL(string: song.artworkUrl100 ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)

            VStack(alignment: .leading) {
                Text(song.artistName ?? "")
                Text(song.trackName ?? "")
                Text(song.collectionName ?? "")
            }
        }
        .padding()
    }
}



struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: Song(artistName: "Artist", trackName: "trackName", collectionName: "collectionName", kind: "kind", wrapperType: "wrapperType", artworkUrl100: "artworkUrl100"))
    }
}
