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
    
    @StateObject private var viewModel = SongListViewModel()
    @State private var selectedGroupBy: GroupBy = .album
    @State private var searchText: String = ""
    
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Picker(selection: $selectedGroupBy, label: Text("Group by")) {
                        ForEach(GroupBy.allCases, id: \.self) { groupBy in
                            Text(groupBy.rawValue.capitalized).tag(groupBy)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 20)
                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(groupedSongs().keys.sorted(), id: \.self) { key in
                                    Section(header: Text(key)) {
                                        ForEach(groupedSongs()[key] ?? []) { song in
                                            SongRow(song: song)
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                        .edgesIgnoringSafeArea([])
                        .navigationTitle("Music")
                    }
                }
                .navigationTitle("Music")
            }
            .tabItem {
                Image(systemName: "music.note.list")
                Text("Music")
            }
            
            NavigationView {
                VStack {
                    SearchBar(text: $searchText)
                        .onChange(of: searchText) { _ in
                            performSearch()
                        }
                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        List(filteredSongs) { song in
                            SongRow(song: song)
                        }
                        .listStyle(GroupedListStyle())
                        .edgesIgnoringSafeArea([])
                    }
                }
                .navigationTitle("Search")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
        .tabBarBackground(color: .systemGray6)
        .onAppear {
            viewModel.fetchRequest(query: "beyonce")
        }
    }
    
    private var filteredSongs: [Song] {
        if searchText.isEmpty {
            return viewModel.songs
        } else {
            return viewModel.songs.filter { song in
                let trackMatch = song.trackName?.localizedCaseInsensitiveContains(searchText) == true
                let artistMatch = song.artistName?.localizedCaseInsensitiveContains(searchText) == true
                let collectionMatch = song.collectionName?.localizedCaseInsensitiveContains(searchText) == true
                
                return trackMatch || artistMatch || collectionMatch
            }
        }
    }
    
    private func performSearch() {
        if !searchText.isEmpty {
            viewModel.fetchRequest(query: searchText)
        }
    }
    
    private func groupedSongs() -> [String: [Song]] {
        let songs = viewModel.songs.filter { $0.wrapperType == "collection" || $0.wrapperType == "artist" }
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
    
    struct SongListView_Previews: PreviewProvider {
        static var previews: some View {
            SongListView()
        }
    }
}
