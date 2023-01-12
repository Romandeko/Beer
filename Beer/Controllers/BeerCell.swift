//
//  BeerCell.swift
//  Beer
//
//  Created by Роман Денисенко on 11.01.23.
//

import UIKit

class BeerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var beerResult: Beer! {
        didSet {
            nameLabel.text = beerResult.name
            countLabel.text = "\(beerResult.count) шт."
            countryLabel.text = beerResult.country
            if beerResult.count <= 0{
                countLabel.text = "Закончилось"
            }
        }
    }
    static let identifier = "BeerCell"

    
}
