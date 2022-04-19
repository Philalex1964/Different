//
//  EpisodesViewModel.swift
//  Cocoacasts
//
//  Created by Bart Jacobs on 17/10/2021.
//

import Combine
import Foundation

final class EpisodesViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var episodes: [Episode] = []

    @Published private(set) var isFetching = false

    // MARK: -

    var episodeRowViewModels: [EpisodeRowViewModel] {
        episodes.map { EpisodeRowViewModel(episode: $0) }
    }

    // MARK: -

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init() {
        fetchEpisodes()
    }

    // MARK: - Helper Methods

    private func fetchEpisodes() {
        // MARK: - Reactive Approach
        var request = URLRequest(url: URL(string: "https://cocoacasts-mock-api.herokuapp.com/api/v1/episodes")!)
        
        request.addValue("1772bb7bc78941e2b51c9c67d17ee76e", forHTTPHeaderField: "X-API-TOKEN")
        
        isFetching = true
        
        URLSession.shared.dataTaskPublisher(for: request)
            .retry(1) //easy in reactive approach
            .map(\.data)
            .decode(type: [Episode].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print("Unable to Fetch Episodes \(error)")
                }
            }, receiveValue: { [weak self] episodes in
                self?.episodes = episodes
            }).store(in: &subscriptions)
        
        
        // MARK: - Traditional, Imperative Approach
        /*
        var request = URLRequest(url: URL(string: "https://cocoacasts-mock-api.herokuapp.com/api/v1/episodes")!)
        
        request.addValue("1772bb7bc78941e2b51c9c67d17ee76e", forHTTPHeaderField: "X-API-TOKEN")
        
        isFetching = true
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isFetching = false
                
                if error != nil || (response as? HTTPURLResponse)?.statusCode != 200 {
                    print("Unable to Fetch Episodes")
                } else if let data = data, let episodes = try? JSONDecoder().decode([Episode].self, from: data) {
                    self?.episodes = episodes
                }
            }
        }.resume()
        */
        
        
        // MARK: - Bundle variant
        /*
        guard
            let url = Bundle.main.url(forResource: "episodes", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let episodes = try? JSONDecoder().decode([Episode].self, from: data)
        else {
            return
        }

        self.episodes = episodes
         */
    }

}
