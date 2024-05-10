//
//  PokemonListPresenter.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//


import UIKit

protocol PokemonListPresentationLogic {
    var viewController: PokemonListDisplayLogic? { get set }
    func presentFetchPokemonList(response: PokemonListModel.FetchList.Response)
    func presentFecthEachPokemon(item: [PokemonDetails.Details.Response])
}

class PokemonListPresenter: PokemonListPresentationLogic {
    var viewController: PokemonListDisplayLogic?
    
    
    func presentFetchPokemonList(response: PokemonListModel.FetchList.Response) {
        self.viewController?.displayFetchPokemonList(viewModel: .init(results: response.results))
    }
    
    
    func presentFecthEachPokemon(item: [PokemonDetails.Details.Response]) {
        self.viewController?.displayFecthEachPokemon(item: item)
    }
}
