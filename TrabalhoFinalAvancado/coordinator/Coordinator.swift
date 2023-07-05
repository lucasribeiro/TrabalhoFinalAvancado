//
//  Coordinator.swift
//  TrabalhoFinalAvancado
//
//  Created by Lucas Luis Ribeiro on 29/06/23.
//

import Foundation
import UIKit

enum Routes {
    case moviesList
    case moviesDetails
}

protocol Coordinator { // only COORDINATORS
    var navigationController: UINavigationController? { get set }
    //    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func navigate(to route: Routes, data: Any?)
}

protocol Coordinating { // View Controllers para usar o coordinator
    var coordinator: Coordinator? {get set}
}
