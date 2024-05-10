import UIKit

protocol PokemonDetailsRoutingLogic {
}

protocol PokemonDetailsDataPassing {
  var dataStore: PokemonDetailsDataStore? { get set }
}

class PokemonDetailsRouter: NSObject, PokemonDetailsRoutingLogic, PokemonDetailsDataPassing {
  weak var viewController: PokemonDetailsViewController?
  var dataStore: PokemonDetailsDataStore?
  

}
