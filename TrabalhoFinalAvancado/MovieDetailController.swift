//
//  MovieDetailController.swift
//  TrabalhoFinalAvancado
//
//  Created by Lucas Luis Ribeiro on 29/06/23.
//

import Foundation
import UIKit

class MovieDetailController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    var viewModel: MovieDetailViewModel?
    var movieId: String
    
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let voteAverage = UILabel()
    let voteCount = UILabel()
    
    init(movieId: String) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
        super.viewDidLoad()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Configura a imagem
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "imagem1.jpg") // Substitua "imagem.jpg" pelo nome da sua imagem
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        // Configura o título
        titleLabel.text = "Título da Imagem"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Configura a descrição
        voteAverage.text = "Descrição da Imagem"
        voteAverage.font = UIFont.systemFont(ofSize: 18)
        voteAverage.textAlignment = .center
        voteAverage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(voteAverage)
        
        // Configura as votações
        voteCount.text = "123 votações"
        voteCount.font = UIFont.systemFont(ofSize: 16)
        voteCount.textAlignment = .center
        voteCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(voteCount)

        setupConstraints()
        
        self.view.backgroundColor = .white
        
        bindSetup()
        
        // HIGHLIGHT -> COnstruir a tela
        viewModel?.fetchMovie(movieId: movieId)
    }
    
    func bindSetup() {
        viewModel = MovieDetailViewModel( service: MoviesService())
        viewModel?.updateMovieDetails = updateScreen
        
    }
    
    func updateScreen() {
        
        let tmdbImagePath = "https://image.tmdb.org/t/p/original"
      
              
        DispatchQueue.main.async { [weak self] in
            
            let imageURL = tmdbImagePath + (self?.viewModel?.movie?.posterPath ?? "")
            guard let url = URL(string: imageURL) else {
                        return
                    }
            
            if let imageData = try? Data(contentsOf: url) {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
            
            self?.titleLabel.text = "Título: \(self?.viewModel?.movie?.title ?? "")"
            self?.voteAverage.text = "Pontuação Média: \(String(self?.viewModel?.movie?.voteAverage ?? 0.0))"
            self?.voteCount.text = "Total de votos: \(String(self?.viewModel?.movie?.voteCount ?? 0))"
        }
    }
   
    
    func setupConstraints() {
        let margin: CGFloat = 10

        // Constraints para a imagem
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        // Constraints para o título
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        
        // Constraints para a descrição
        voteAverage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin).isActive = true
        voteAverage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        voteAverage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
        
        // Constraints para as votações
        voteCount.topAnchor.constraint(equalTo: voteAverage.bottomAnchor, constant: margin).isActive = true
        voteCount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        voteCount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin).isActive = true
    }
}
