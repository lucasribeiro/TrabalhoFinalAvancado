//
//  ViewController.swift
//  TrabalhoFinalAvancado
//
//  Created by Lucas Luis Ribeiro on 29/06/23.
//

import UIKit

class ViewController: UIViewController, Coordinating, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    let cellReuseIdentifier = "cell"
    var coordinator: Coordinator?
    /*let data = [("imagem1.jpg", "Texto da célula 1"),
                ("imagem2.jpg", "Texto da célula 2"),
                ("imagem3", "Texto da célula 3"),
                ("imagem4", "Texto da célula 4"),
                ("imagem5", "Texto da célula 5")]
     */
    
    private var viewModel: MoviesViewModel!
    
    // BIND GET SETUP
    private var data: [Movies] {
        return viewModel.model.movies
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Minha Tabela" // Definir o título da tela
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Registre a classe da célula personalizada para reutilização
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // Espaçamento maior entre as células
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        bindSetup()
        
        // BIND ASK DATA
        viewModel.getMovies()
        
    }
    
    private func bindSetup() {
        viewModel = MoviesViewModel(movies: MoviesModel(), service: MoviesService())
        viewModel.reloadTable = self.reloadTable
    }
    
    private func didTapCell(position: IndexPath) {
        let id = String(data[position.row].id)
        
        print("Célula selecionada: \(id)")
        
        //coordinator?.navigate(to: .moviesDetails, data: id)
        
        // WITHOUT COORDINATOR
        self.present(MovieDetailController(movieId: id), animated: true)
        //coordinator?.navigate(to: .moviesDetails, data: id)
    }
    
    
    // BIND VIEW - REACTIVE RELOAD FROM VIEW MODEL
    func reloadTable() -> Void {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Retorne o número de células que você deseja exibir
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        let rowData = data[indexPath.row]
        cell.configure(with: rowData)
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapCell(position: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class CustomTableViewCell: UITableViewCell {
    let customImageView = UIImageView()
    let customLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customImageView.contentMode = .scaleAspectFit
        contentView.addSubview(customImageView)
        
        customLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(customLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        customImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        customImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        customImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        customLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16).isActive = true
        customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    func configure(with data: (Movies)) {
        let tmdbImagePath = "https://image.tmdb.org/t/p/original"
        let imageURL = tmdbImagePath + data.posterPath
        guard let url = URL(string: imageURL) else {
                    return
                }
                
                DispatchQueue.global().async { [weak self] in
                    if let imageData = try? Data(contentsOf: url) {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self?.customImageView.image = image
                        }
                    }
                }
        customLabel.text = data.originalTitle
    }
}

