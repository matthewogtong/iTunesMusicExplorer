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
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: song.artworkUrl100 ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 5) {
                Text(song.trackName ?? "")
                    .font(.headline)
                Text(song.artistName ?? "")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(song.collectionName ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(10)
            .padding(.trailing, 5)
            .frame(maxWidth: 250, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.purple))
            )
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}



struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: Song(artistName: "Artist", trackName: "trackName", collectionName: "collectionName", kind: "kind", wrapperType: "wrapperType", artworkUrl100: "artworkUrl100"))
    }
}
