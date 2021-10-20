# ShakespeareanPokemon

A lightweight app to search for Pokemon and load its image and Shakespearean description.

# Usage

1. Open `ShakespeareanPokemon.xcodeproj`.

That's it! This project integrates with `SwiftyShakespeareanPokemon` via Swift Package Manager, so Xcode should automatically fetch the package upon opening. If it does not, you may need to click `File > Packages > Resovle Package Versions`.

# Architecture & Features
- The `DetailViewController` is responsible for displaying the Pokemon information. It uses VIPER (View, Interactor, Presenter, Entity, and Router). The class names are similarly named.
- It features protocols for these classes, to allow unit testing in the future.

# Further Improvements & Notes
- I could not find a search endpoint in the PokeAPI, so I created a large JSON file of all the Pokemon using one of their endpoints. I load this in `ViewController` and filter it with the search String there.
- I tested this using Xcode 13.0 on an iPhone 12 Pro Max simulator with iOS 15. There is a bug in the iPod touch simulator where you cannot present a `ViewController` when using a `UISearchController`.
- I would refactor `ViewController` as currently it is a massive view controller - I would separate the `UITableViewDataSource` and delegate functionality into its own class, as well as `UISearchResultsUpdating`. I'd then use the VIPER architecture for this `ViewController`, too.
- I'd spice up the UI a little - currently it's a bit bland.
- I'd add UI tests using XCUITest.
