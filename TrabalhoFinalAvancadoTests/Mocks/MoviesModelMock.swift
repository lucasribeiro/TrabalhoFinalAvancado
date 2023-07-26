//
//  MovieDetailViewModelMock.swift
//  TrabalhoFinalAvancadoTests
//
//  Created by Lucas Luis Ribeiro on 25/07/23.
//

import Foundation
@testable import TrabalhoFinalAvancado

class MoviesModelMock: MoviesModelType {
    var movies: [Movies] = []
    var didCalledGetMoviesTimes = 0
    var didCalledSetMoviesTimes = 0
    
    func setMovies(response: Data?) {
        didCalledSetMoviesTimes += 1
    }
    
    func getMovies(completion: @escaping (Data?, Error?) -> Void) {
        didCalledGetMoviesTimes += 1
    }
}
