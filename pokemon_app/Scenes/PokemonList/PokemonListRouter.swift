//
//  PokemonListRouter.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//

import UIKit

protocol PokemonListRoutingLogic {
    func routeToDetails(info: PokemonDetails.Details.Response)
}

protocol PokemonListDataPassing {
  var dataStore: PokemonListDataStore? { get }
}

class PokemonListRouter: PokemonListRoutingLogic, PokemonListDataPassing {
    var viewController: PokemonListViewController?
    var dataStore: PokemonListDataStore?
    
    func routeToDetails(info: PokemonDetails.Details.Response) {
        let detailsVC: PokemonDetailsViewController = PokemonDetailsViewController(nibName: "PokemonDetailsViewController", bundle: nil)
        detailsVC.router?.dataStore?.infomation = info
        self.viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
