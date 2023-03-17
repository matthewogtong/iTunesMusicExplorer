//
//  SongListView.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import SwiftUI

import SwiftUI

struct SongListView: View {

    @StateObject private var songListViewModel = SongListViewModel()

    var body: some View {
        NavigationView {

            if songListViewModel.isLoading {
                ProgressView()
            } else {
                List(songListViewModel.songs) { song in
                    SongRow(song: song)
                }
            }
        }
        .onAppear(perform: songListViewModel.fetchRequest)
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView()
    }
}
