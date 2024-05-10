//
//  PokemonListViewModel.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//
struct PokemonListModel {
    struct FetchList {
        struct Response: Decodable {
            var count: Int
            var next: String
            var previous: String
            var results: [PokemonListModel.PokemonInfo]
        }
        struct ViewModel {
            var results: [PokemonListModel.PokemonInfo]
        }
    }
    
    struct PokemonInfo: Decodable {
        var name: String
        var url: String
    }
}
