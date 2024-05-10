//
//  PokemonListViewController.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//

import UIKit

protocol PokemonListDisplayLogic {
    func displayFetchPokemonList(viewModel: PokemonListModel.FetchList.ViewModel)
    func displayFecthEachPokemon(item: [PokemonDetails.Details.Response])
    
}

class PokemonListViewController: UIViewController, PokemonListDisplayLogic, UITableViewDataSource, UITableViewDelegate {
    
    var interactor: PokemonListInteractor?
    var router: (PokemonListRoutingLogic & PokemonListDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var pokemonList: [PokemonDetails.Details.Response]?
    var currentList: [PokemonDetails.Details.Response]?
    var currentSearch: String = ""
    
    func createModule() -> PokemonListViewController {
        let viewController = PokemonListViewController()
        let interactor = PokemonListInteractor()
        let presenter = PokemonListPresenter()
        let router = PokemonListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.fetchPokemonList(isNext: false)
    }
    
    private func setupView() {
        self.title = "Pokémon's List"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonInfoTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonInfoTableViewCell") as? PokemonInfoTableViewCell, let data = self.currentList?[indexPath.row] else {
            fatalError()
        }
        cell.setupInfo(data)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let info = self.currentList?[indexPath.row] else {
            return
        }
        router?.routeToDetails(info: info)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (currentList?.count ?? 0) - 1 == indexPath.row {
            interactor?.fetchPokemonList(isNext: true)
        }
    }
    
    @IBAction func searchActionHandler(_ sender: Any) {
        self.currentSearch = nameTextField.text ?? ""
        filterName()
    }
    
    func displayFetchPokemonList(viewModel: PokemonListModel.FetchList.ViewModel) {
    }
    
    
    func displayFecthEachPokemon(item: [PokemonDetails.Details.Response]) {
        pokemonList = item
        filterName()
    }
    
    func filterName() {
        if self.currentSearch != "" {
            currentList = pokemonList?.filter { $0.name.contains(self.currentSearch) }
        } else {
            currentList = pokemonList
        }
        tableView.reloadData()
    }
    
}
