//
//  MovieDetailViewModel.swift
//  TrabalhoFinalAvancado
//
//  Created by Lucas Luis Ribeiro on 04/07/23.
//

import Foundation

class MovieDetailViewModel {
    var movie: MovieDetail?
    private let service: MoviesServiceType
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    
    var updateMovieDetails: (() -> Void)?
    
    init(service: MoviesServiceType) {
        self.service = service
    }
    
    func fetchMovie(movieId: String) {
        showLoading?() //startLoading
        service.getDetails(movieId: movieId, completion: { [weak self] data, error in
            let responseData = try? JSONDecoder().decode(MovieDetail.self, from: data!)
            self?.movie = responseData
            self?.updateMovieDetails?()
            self?.hideLoading?() // hideLoading
        })
    }
}
