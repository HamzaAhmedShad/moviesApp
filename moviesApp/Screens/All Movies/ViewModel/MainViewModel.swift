//
//  MainViewModel.swift
//  moviesApp
//
//  Created by BS1101 on 6/6/23.
//

import Foundation
final class MainViewModel{
    var movie: [Movie] = []
    var favMovie: [Movie] = []
    static let shared = MainViewModel()
    var eventHandler: ((_ event: Event) ->Void)?
    
    func fetchMovies(){
        self.eventHandler?(.loading)
        
        APIManager.shared.fetchMovies { [weak self] response in
            guard let self = self else{return}
            self.eventHandler?(.stopLoading)
            
            switch response{
            case .success(let movies):
                self.movie = movies
                self.eventHandler?(.dataLoaded)
                print(movies)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
extension MainViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}

extension MainViewModel{
    func toggleFavorite(movie: Movie) {
        if let index = favMovie.firstIndex(where: { $0.id == movie.id }) {
            favMovie.remove(at: index)
        } else {
            favMovie.append(movie)
        }
    }
    func isInFavorites(movie: Movie) -> Bool {
        return self.favMovie.contains { $0.id == movie.id }
    }
}
