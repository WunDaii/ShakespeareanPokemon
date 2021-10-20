//
//  ViewController.swift
//  ShakespeareanPokemon
//
//  Created by Daven.Gomes on 17/10/2021.
//

import UIKit
import SwiftyShakespeareanPokemon

final class ViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private var allPokemon: [PokemonResult]?
    private var results: [PokemonResult]?
    @IBOutlet weak var tableView: UITableView!
    private let apiClient = PokeAPIClient()
    private let router: Routing = Router()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shakespearean Pokemon"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokemon"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        do {

            if let path = Bundle.main.path(forResource: "all_pokemon", ofType: "json") {
                let url = URL(fileURLWithPath: path)
                let jsonData = try Data(contentsOf: url)
                allPokemon = try JSONDecoder().decode([PokemonResult].self, from: jsonData)
            }
        } catch {
            print("Could not load all_poken.json: \(error.localizedDescription)")
        }
    }
}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        guard let searchQuery = searchController.searchBar.text else {
            return
        }

        results = allPokemon?.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }

        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Usually I would create a custom cell class and dequeue it,
        // but this isn't necessary here for a simple cell.
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ResultCell")
        cell.textLabel?.text = results?[indexPath.row].name

        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let result = results?[indexPath.row] else { return }

        let detailViewController = DetailViewController()
        detailViewController.pokemonName = result.name
        
        present(
            detailViewController,
            animated: true,
            completion: nil)
    }
}
