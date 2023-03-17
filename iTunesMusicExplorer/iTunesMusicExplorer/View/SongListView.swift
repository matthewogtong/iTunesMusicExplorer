//
//  SongListView.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import SwiftUI

struct SongListView: View {

    enum GroupBy: String, CaseIterable {
        case album
        case musicVideo = "music-video"
        case song
    }

    @StateObject private var songListViewModel = SongListViewModel()
    @State private var selectedGroupBy: GroupBy = .album

    private func groupedSongs() -> [String: [Song]] {
        let songs = songListViewModel.songs.filter { $0.wrapperType == "collection" || $0.wrapperType == "artist" }
        var groupedSongs = [String: [Song]]()

        switch selectedGroupBy {
        case .album:
            groupedSongs = Dictionary(grouping: songs.filter { $0.kind == nil }, by: { _ in "Album" })
        case .musicVideo:
            groupedSongs = Dictionary(grouping: songs.filter { $0.kind == GroupBy.musicVideo.rawValue }, by: { $0.kind ?? "" })
        case .song:
            groupedSongs = Dictionary(grouping: songs.filter { $0.kind == GroupBy.song.rawValue }, by: { $0.kind ?? "" })
        }

        return groupedSongs
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selectedGroupBy, label: Text("Group by")) {
                    ForEach(GroupBy.allCases, id: \.self) { groupBy in
                        Text(groupBy.rawValue.capitalized).tag(groupBy)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)

                if songListViewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                        if selectedGroupBy == .album {
                            Section(header: Text("Album")) {
                                ForEach(songListViewModel.songs.filter { $0.kind == nil }) { song in
                                    SongRow(song: song)
                                }
                            }
                        }
                        if selectedGroupBy == .musicVideo {
                            ForEach(groupedSongs().keys.sorted(), id: \.self) { key in
                                Section(header: Text(key)) {
                                    ForEach(songListViewModel.songs.filter { $0.kind == GroupBy.musicVideo.rawValue && $0.kind == key }) { song in
                                        SongRow(song: song)
                                    }
                                }
                            }
                        }
                        if selectedGroupBy == .song {
                            ForEach(groupedSongs().keys.sorted(), id: \.self) { key in
                                Section(header: Text(key)) {
                                    ForEach(songListViewModel.songs.filter { $0.kind == GroupBy.song.rawValue && $0.kind == key }) { song in
                                        SongRow(song: song)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
            }
            .navigationTitle("Music")
        }
        .onAppear(perform: songListViewModel.fetchRequest)
    }

    struct SongListView_Previews: PreviewProvider {
        static var previews: some View {
            SongListView()
        }
    }
}
