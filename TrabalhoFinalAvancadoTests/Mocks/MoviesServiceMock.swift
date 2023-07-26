//
//  MoviesServiceMock.swift
//  TrabalhoFinalAvancadoTests
//
//  Created by Lucas Luis Ribeiro on 25/07/23.
//

import Foundation
@testable import TrabalhoFinalAvancado

class MoviesServiceMock: MoviesServiceType {
    
    
    var didCalledGetMoviesTimes = 0
    var didCalledGeDetailimes = 0
    
    func getDetails(movieId: String, completion: @escaping (Data?, Error?) -> Void) {
        didCalledGeDetailimes += 1
    }

    func getMovies(completion: @escaping (Data?, Error?) -> Void) {
        didCalledGetMoviesTimes += 1
    }
}
