//
//  PokemonDetailsViewController.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//  Copyright (c) 2567 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PokemonDetailsDisplayLogic {
    func displaySetupView(info: PokemonDetails.Details.Response?)
}

class PokemonDetailsViewController: UIViewController, PokemonDetailsDisplayLogic {
    var interactor: PokemonDetailsBusinessLogic?
    var router: (NSObjectProtocol & PokemonDetailsRoutingLogic & PokemonDetailsDataPassing)?
    
    @IBOutlet weak var backShineImage: UIImageView!
    @IBOutlet weak var frontShineImage: UIImageView!
    @IBOutlet weak var blackImage: UIImageView!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PokemonDetailsInteractor()
        let presenter = PokemonDetailsPresenter()
        let router = PokemonDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchPokemonDetails()
        setupView()
    }
    
    func setupView() {
        let backItem = UIBarButtonItem(title: "", style: .plain, target: self, action:  #selector(tapToBack))
        backItem.image = UIImage(named: "Back")
        backItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    @objc func tapToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func displaySetupView(info: PokemonDetails.Details.Response?) {
        self.title = info?.name ?? "Pokémon's Details"
        detailsTitleLabel.text = "\(info?.name ?? "")'s details"
        frontImage.imageFromUrl(urlString: info?.sprites?.frontImageUrl ?? "")
        backShineImage.imageFromUrl(urlString: info?.sprites?.backShineImageUrl ?? "")
        frontShineImage.imageFromUrl(urlString: info?.sprites?.frontShineImageUrl ?? "")
        blackImage.imageFromUrl(urlString: info?.sprites?.backImageUrl ?? "")
        idLabel.text = "\(info?.id ?? 0)"
        heightLabel.text = "\(info?.height ?? 0)"
        weightLabel.text = "\(info?.weight ?? 0)"
        experienceLabel.text = "\(info?.experiencePoint ?? 0)"
    }
}
