//
//  File.swift
//  
//
//  Created by Daven.Gomes on 19/10/2021.
//

import Foundation

protocol DetailPresenting {
    
    func viewControllerDidLoad(
        _ viewController: DetailViewController)
}

final class DetailPresenter: DetailPresenting {
    
    private let pokemonName: String
    private let interactor: DetailInteracting
    private let mainDispatcher: Dispatching
    
    init(pokemonName: String,
         interactor: DetailInteracting,
         mainDispatcher: Dispatching) {
        
        self.pokemonName = pokemonName
        self.interactor = interactor
        self.mainDispatcher = mainDispatcher
    }
    
    func viewControllerDidLoad(
        _ viewController: DetailViewController) {
            
            interactor.loadPokeDescription(
                for: pokemonName) { [weak self] result in
                    
                    guard let strongSelf = self else {
                        return
                    }
                    
                    strongSelf.mainDispatcher.async {
                        
                        switch result {
                        case .success(let description):
                            viewController.setPokemonDescription(description)
                        case .failure(let error):
                            viewController.setPokemonDescription(error.localizedDescription)
                        }
                    }
                }
            
            interactor.loadPokeSprite(
                for: pokemonName) { [weak self] result in
                    
                    guard let strongSelf = self else {
                        return
                    }
                    
                    switch result {
                    case .success(let image):
                        
                        strongSelf.mainDispatcher.async {
                            viewController.setPokemonImage(image)
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        break
                    }
                }
        }
}
