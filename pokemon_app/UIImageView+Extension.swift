//
//  UIImageView+Extension.swift
//  pokemon_app
//
//  Created by Mookmaleawja . on 7/5/2567 BE.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    public func imageFromUrl(urlString: String) {
        AF.request(urlString).responseImage { response in
            if let image = response.value?.resizableImage(withCapInsets: .zero, resizingMode: .stretch) {
                self.image = image
            }
        }
    }
}
