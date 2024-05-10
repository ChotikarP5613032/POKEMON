//
//  PokemonListInteractor.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//

import Foundation
import Alamofire

protocol PokemonListBusinessLogic {
    func fetchPokemonList(isNext: Bool)
}

protocol PokemonListDataStore {
}

class PokemonListInteractor: PokemonListDataStore, PokemonListBusinessLogic {
    var presenter: PokemonListPresentationLogic?
    var pokemonData: PokemonListModel.FetchList.Response?
    var pokemonDataList: [PokemonDetails.Details.Response] = []
    
    func fetchPokemonList(isNext: Bool) {
        var currentUrl: String = "https://pokeapi.co/api/v2/pokemon?limit=0&offset=100"
        if isNext {
            currentUrl = pokemonData?.next ?? ""
        }
        AF.request(currentUrl).responseDecodable(of: PokemonListModel.FetchList.Response.self) { response in
            guard let data = response.value else { return }
            for i in data.results {
                self.fetchEachPokemon(name: i.name)
            }
            if self.pokemonData == nil {
                self.pokemonData = data
            } else {
                var list: [PokemonListModel.PokemonInfo] = self.pokemonData?.results ?? []
                list.append(contentsOf: data.results)
                self.pokemonData = PokemonListModel.FetchList.Response(count: data.count, next: data.next, previous: data.previous, results: list)
            }
            guard let currentData = self.pokemonData else { return }
            self.presenter?.presentFetchPokemonList(response: currentData)
        }
    }
    
    private func fetchEachPokemon(name: String) {
        let url: String = String(format: "https://pokeapi.co/api/v2/pokemon/%@/", name)
        AF.request(url).responseDecodable(of: PokemonDetails.Details.Response.self) { response in
            guard let data = response.value else { return }
            self.pokemonDataList.append(data)
            self.presenter?.presentFecthEachPokemon(item: self.pokemonDataList)
        }
    }
}
