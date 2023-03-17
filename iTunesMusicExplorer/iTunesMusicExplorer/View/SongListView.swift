//
//  SongListView.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import SwiftUI

struct SongListView: View {

    @StateObject private var songListViewModel = SongListViewModel()

    private func groupedSongs() -> [String: [Song]] {
        Dictionary(grouping: songListViewModel.songs, by: { $0.kind ?? "" })
    }

    var body: some View {
        NavigationView {
            if songListViewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(groupedSongs().keys.sorted(), id: \.self) { key in
                            Section(header: Text(key)) {
                                ForEach(groupedSongs()[key] ?? []) { song in
                                    SongRow(song: song)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: songListViewModel.fetchRequest)
    }

    struct SongListView_Previews: PreviewProvider {
        static var previews: some View {
            SongListView()
        }
    }
}
