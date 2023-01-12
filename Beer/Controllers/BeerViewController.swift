//
//  BeerViewController.swift
//  Beer
//
//  Created by Роман Денисенко on 11.01.23.
//

import UIKit

class BeerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var halfButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let beerViewModel = BeerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = addButton.frame.height / 2
        setupInfo()
        bindViewModel()
    }
    
    private func setupInfo(){
        nameLabel.text = beerViewModel.currentBeer.value.name
        countryLabel.text = beerViewModel.currentBeer.value.country
        costLabel.text = "\(beerViewModel.currentBeer.value.price)$"
        imageView.image =  beerViewModel.currentBeer.value.image
        
        beerViewModel.currentBeerCount.value = beerViewModel.currentBeer.value.count
        beerViewModel.currentPrice.value = beerViewModel.currentBeer.value.price
    }
    
    func bindViewModel(){
        beerViewModel.currentPrice.bind(listener: { [weak self] currentPrice   in
            self?.costLabel.text = "\(currentPrice)$"
        })
        
        beerViewModel.currentBeerCount.bind(listener: { [weak self] currentBeerCount   in
            self?.countLabel.text = "\(currentBeerCount) шт."
        })
    }
    
    @IBAction func chooseVolume(_ sender: UIButton) {
        halfButton.isSelected = false
        oneButton.isSelected = false
        twoButton.isSelected = false
        sender.isSelected = true
        beerViewModel.currentPrice.value = ( beerViewModel.currentBeer.value.price * (Double(sender.currentTitle ?? "") ?? 0))
        
    }
    
    @IBAction func closeVc(_ sender: Any) {
        guard let destinationViewController = self.presentingViewController as?
                ViewController else { return }
        destinationViewController.beerViewModel.allBeerPrice.value += beerViewModel.allBeerPrice.value
        destinationViewController.beerViewModel.beers.value[beerViewModel.index.value].count = beerViewModel.currentBeerCount.value
        destinationViewController.tableView.reloadData()
        dismiss(animated: true)
    }
    
    @IBAction func addBeer(_ sender: Any) {
        beerViewModel.addBeer()
    }
}



