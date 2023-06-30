//
//  MoviesViewModel.swift
//  TrabalhoFinalAvancado
//
//  Created by Lucas Luis Ribeiro on 29/06/23.
//

import Foundation

class MoviesViewModel {
    private let service: MoviesServiceType
    var model: MoviesModelType
    
    var reloadTable: (() -> Void)?
    
    init(movies: MoviesModelType, service: MoviesServiceType) {
        self.model = movies
        self.service = service
    }
    
    func getMovies() {
        service.getMovies { [weak self] data, error in
            self?.model.setMovies(response: data)
            self?.reloadTable?()
        }
    }
}
