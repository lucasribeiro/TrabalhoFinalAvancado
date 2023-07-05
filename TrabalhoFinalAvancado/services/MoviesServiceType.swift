//
//  MoviesServiceType.swift
//  TrabalhoFinalAvancado
//
//  Created by Lucas Luis Ribeiro on 29/06/23.
//

import Foundation

protocol MoviesServiceType {
    func getMovies(completion: @escaping (Data?, Error?) -> Void) -> Void
    func getDetails(movieId: String, completion: @escaping (Data?, Error?) -> Void) -> Void
}

class MoviesService: MoviesServiceType {
    let uri: String = "https://api.themoviedb.org/3/movie"
    let topRatedEndpoint: String = "/top_rated"
    let apiKey: String = "bf84cdeb880ea4a901655b683a30662c"
    
    func getMovies(completion: @escaping (Data?, Error?) -> Void) -> Void {
        let url = "\(uri)\(topRatedEndpoint)?api_key=\(apiKey)"
        
        URLSession.shared.dataTask(with: URL(string: url)!,
           completionHandler: { (data, response, error) in
                completion(data, error)
            }
        ).resume()
    }
    
    func getDetails(movieId: String, completion: @escaping (Data?, Error?) -> Void) -> Void {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)")!,
           completionHandler: { (data, response, error) in
                completion(data, error)
            }
        ).resume()
    }
}
