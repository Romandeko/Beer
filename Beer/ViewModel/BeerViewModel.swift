//
//  BeerViewModel.swift
//  Beer
//
//  Created by Роман Денисенко on 11.01.23.
//

import Foundation
import UIKit.UIImage

public class BeerViewModel {
    
    var beers = Box([Beer]())
    var index  = Box(Int(0))
    var allBeerPrice = Box(Double(0))
    var currentPrice = Box(Double(0))
    var currentBeerCount = Box(Int(0))
    var currentBeer = Box(Beer(name: "", country: "", price: 1, count: 1, image: UIImage(named: "Heineken")))
    
    func buyAllBeer(){
        allBeerPrice.value = 0
    }
    
    func setupBeer(){
        beers.value.append( Beer(name: "Балтика", country: "🇷🇺", price: 100, count: 4, image: UIImage(named: "Балтика")))
        
        beers.value.append(  Beer(name: "Аливария", country: "🇧🇾", price: 18, count: 47, image: UIImage(named: "Аливария")))
        
        beers.value.append( Beer(name: "Жигулёвское", country: "🇧🇾", price: 75, count: 101, image: UIImage(named: "Жигулёвское")))
        
        beers.value.append(Beer(name: "Туборг", country: "🇷🇺", price: 26, count: 255, image: UIImage(named: "Туборг")))
        
        beers.value.append( Beer(name: "Heineken", country: "🇳🇱", price: 114, count: 39, image: UIImage(named: "Heineken")))
        
    }
    
    func addBeer(){
        guard currentBeerCount.value > 0 else { return }
        allBeerPrice.value += currentPrice.value
        currentBeerCount.value -= 1
    }
    
}
