//
//  HomeViewController.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
     @IBAction func letgoActionHandler(_ sender: Any) {
         let vc = PokemonListViewController(nibName: "PokemonListViewController", bundle: nil).createModule()
         let navigation = UINavigationController(rootViewController: vc)
         UIApplication.shared.windows.first?.rootViewController = navigation
         UIApplication.shared.windows.first?.makeKeyAndVisible()
     }

}
