//
//  Router.swift
//  ShakespeareanPokemon
//
//  Created by Daven Gomes on 20/10/2021.
//

import Foundation
import UIKit

protocol Routing {
    
    func navigateToDetailView(for pokemonName: String,
                              from viewController: UIViewController)
}

final class Router: Routing {
    
    func navigateToDetailView(for pokemonName: String,
                              from viewController: UIViewController) {
        
        let detailViewController = DetailViewController()
        detailViewController.pokemonName = pokemonName
        
        viewController.present(
            detailViewController,
            animated: true,
            completion: nil)
    }
}
