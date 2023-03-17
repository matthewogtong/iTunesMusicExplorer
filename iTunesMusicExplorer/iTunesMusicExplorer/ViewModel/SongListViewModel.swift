//
//  SongListViewModel.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {

    @Published var songs: [Song] = []
    @Published var isLoading = false
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkService()) {
        self.networkManager = networkManager
    }

    func fetchRequest(query: String = "beyonce") {
        isLoading = true
        networkManager.fetchRequest(query: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let songs):
                    self?.songs = songs
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.isLoading = false
            }
        }
    }

}
