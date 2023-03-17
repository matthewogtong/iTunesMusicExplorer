//
//  SongListViewModel.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {

    @Published private(set) var songs: [Song] = []
    @Published var isLoading: Bool = false

    let networkService = NetworkService()

    func fetchRequest() {
        networkService.fetchRequest { [weak self] result in

            DispatchQueue.main.async {
                switch result {
                case .success(let songs):
                    self?.songs = songs
                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
}
