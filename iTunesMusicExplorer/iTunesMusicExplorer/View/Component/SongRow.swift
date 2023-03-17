//
//  SongRow.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import SwiftUI

struct SongRow: View {

    let song: Song

    private func songImage() -> some View {
        AsyncImage(url: song.artworkUrl100.flatMap(URL.init)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
        }
        .frame(width: 80, height: 80)
    }

    private func songInfoBackground() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(.purple))
    }

    var body: some View {
        HStack(alignment: .center) {
            songImage()
                .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 5) {
                song.trackName.map(Text.init)
                    .font(.headline)
                song.artistName.map(Text.init)
                    .font(.headline)
                    .foregroundColor(.secondary)
                song.collectionName.map(Text.init)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.all, 10)
            .frame(maxWidth: 250, alignment: .leading)
            .background(songInfoBackground())
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
