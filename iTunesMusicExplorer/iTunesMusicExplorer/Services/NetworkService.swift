//
//  NetworkService.swift
//  iTunesMusicExplorer
//
//  Created by Matthew Ogtong on 3/16/23.
//

import Foundation 

protocol NetworkManager {
    func fetchRequest(completion: @escaping (Result<[Song], Error>) -> Void)
}

class NetworkService: NetworkManager {


    func fetchRequest(completion: @escaping (Result<[Song], Error>) -> Void) {
        let urlString = APIConstants.baseURL
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 100)))
            return
        }

        performRequest(url: url, method: "GET", body: nil, completion: completion)
    }

    func performRequest(url: URL, method: String, body: Data?, completion: @escaping (Result<[Song], Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, _, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Error fetching data", code: 100)))
                return
            }

            let decoder = JSONDecoder()

            do {
                let decodedObject = try decoder.decode(InitialResponse.self, from: data)
                completion(.success(decodedObject.results))
            } catch {
                completion(.failure(error))
            }


        }
        task.resume()
    }

}

