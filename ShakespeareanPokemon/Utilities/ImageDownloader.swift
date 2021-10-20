//
//  File.swift
//  
//
//  Created by Daven.Gomes on 19/10/2021.
//


import UIKit
import SwiftyShakespeareanPokemon

protocol ImageDownloading {
    func downloadImage(with url: URL,
                       completion: @escaping (Result<UIImage, PokeShakespeareError>) -> Void)
}

final class ImageDownloader: ImageDownloading {

    private let backgroundDispatcher: Dispatching

    init(backgroundDispatcher: Dispatching) {
        self.backgroundDispatcher = backgroundDispatcher
    }

    func downloadImage(with url: URL,
                       completion: @escaping (Result<UIImage, PokeShakespeareError>) -> Void) {

        backgroundDispatcher.async {
            do {
                let data = try Data(contentsOf: url)

                guard let image = UIImage(data: data) else {
                    completion(.failure(.couldNotCreateImageFromData))
                    return
                }

                completion(.success(image))
            } catch {
                completion(.failure(.couldNotGetImageDataFromURL))
            }
        }
    }
}
