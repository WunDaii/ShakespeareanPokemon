//
//  DetailViewController.swift
//  ShakespeareanPokemon
//
//  Created by Daven Gomes on 20/10/2021.
//

import UIKit
import SwiftyShakespeareanPokemon

final class DetailViewController: UIViewController {
    
    var pokemonName: String!
    private var presenter: DetailPresenting!
    private var pokemonDetailChildViewController: PokeShakespeareDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonDetailChildViewController = SwiftyShakespeareanPokemon.makePokemonDetailView()
        pokemonDetailChildViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(pokemonDetailChildViewController.view)
        pokemonDetailChildViewController.didMove(toParent: self)
        definesPresentationContext = true
        
        pokemonDetailChildViewController.titleLabel.text = pokemonName
        pokemonDetailChildViewController.detailLabel.text = "Loading shakespeare description..."
        
        let pokeAPIClient = PokeAPIClient()
        let shakespeareAPIClient = ShakespeareAPIClient()
        let backgroundDispatcher = Dispatcher(queue: Foundation.DispatchQueue(label: UUID().uuidString))
        let mainDispatcher = Dispatcher(queue: Foundation.DispatchQueue.main)
        let imageDownloader = ImageDownloader(backgroundDispatcher: backgroundDispatcher)
        let interactor = DetailInteractor(
            pokeAPIClient: pokeAPIClient,
            shakespeareAPIClient: shakespeareAPIClient,
            imageDownloader: imageDownloader)
        presenter = DetailPresenter(pokemonName: pokemonName,
                                    interactor: interactor,
                                    mainDispatcher: mainDispatcher)
        
        presenter.viewControllerDidLoad(self)
    }
    
    func setPokemonDescription(_ pokemonDescription: String) {
        pokemonDetailChildViewController.detailLabel.text = pokemonDescription
    }
    
    func setPokemonImage(_ image: UIImage) {
        pokemonDetailChildViewController.imageView.image = image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pokemonDetailChildViewController.view.bounds = view.bounds
    }
}
