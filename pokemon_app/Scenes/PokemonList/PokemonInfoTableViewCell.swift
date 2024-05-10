//
//  PokemonInfoTableViewCell.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//

import UIKit

class PokemonInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupInfo(_ info: PokemonDetails.Details.Response) {
        nameLabel.text = info.name
        mainImage.imageFromUrl(urlString: info.sprites?.frontImageUrl ?? "")
    }
}
