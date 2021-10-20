//
//  File.swift
//  
//
//  Created by Daven.Gomes on 19/10/2021.
//

import UIKit
import SwiftyShakespeareanPokemon

protocol DetailInteracting {
    
    func loadPokeDescription(
        for name: String,
        completion: @escaping (Result<String, PokeShakespeareError>) -> Void)
    
    func loadPokeSprite(
        for name: String,
        completion: @escaping (Result<UIImage, PokeShakespeareError>) -> Void)
}

final class DetailInteractor: DetailInteracting {
    
    private let pokeAPIClient: PokeAPIClient
    private let shakespeareAPIClient: ShakespeareAPIClient
    private let imageDownloader: ImageDownloading
    
    init(pokeAPIClient: PokeAPIClient,
         shakespeareAPIClient: ShakespeareAPIClient,
         imageDownloader: ImageDownloading) {
        
        self.pokeAPIClient = pokeAPIClient
        self.shakespeareAPIClient = shakespeareAPIClient
        self.imageDownloader = imageDownloader
    }
    
    func loadPokeDescription(
        for name: String,
        completion: @escaping (Result<String, PokeShakespeareError>) -> Void) {
            
            pokeAPIClient.getDescription(
                for: name) { [weak self] result in
                    
                    switch result {
                    case .success(let description):
                        
                        guard let strongSelf = self else {
                            return
                        }
                        
                        strongSelf.loadShakespeareTranslation(
                            for: description,
                               completion: completion)
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func loadPokeSprite(
        for name: String,
        completion: @escaping (Result<UIImage, PokeShakespeareError>) -> Void) {
            
            pokeAPIClient.getSprite(
                for: name) { result in
                    
                    switch result {
                    case .success(let url):
                        
                        self.imageDownloader.downloadImage(
                            with: url,
                            completion: completion)
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    private func loadShakespeareTranslation(
        for text: String,
        completion: @escaping (Result<String, PokeShakespeareError>) -> Void) {
            
            shakespeareAPIClient.translate(
                text,
                completion: completion)
        }
}
