//
//  MainCoordinator.swift
//  TrabalhoFinalAvancado
//
//  Created by Lucas Luis Ribeiro on 29/06/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    //    var childCoordinators = [Coordinator]()
    
    func start() {
        startWithViewCode()
    }
    
    func navigate(to route: Routes, data: Any?) {
        switch route {
        case .moviesDetails:
            guard let movieId = data as? String else { return }
            
            let vc = MovieDetailController(movieId: movieId)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
            
        case .moviesList:
            let vc = ViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    private func startWithStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "moviesList") as? ViewController
        
        guard let vc = vc else { return }
        
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    private func startWithViewCode() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
