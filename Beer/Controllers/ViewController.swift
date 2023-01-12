//
//  ViewController.swift
//  Beer
//
//  Created by Роман Денисенко on 11.01.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    let beerViewModel = BeerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyButton.layer.cornerRadius = buyButton.frame.height / 2
        setUpTable()
        bindViewModel()
    }
    
    private func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BeerCell.identifier, bundle: nil), forCellReuseIdentifier: BeerCell.identifier)
    }
    
    func bindViewModel(){
        beerViewModel.allBeerPrice.bind(listener: { [weak self ] allBeerPrice   in
            self?.totalPriceLabel.text = "Total price: \(allBeerPrice)$"
        })
        
        beerViewModel.setupBeer()
    }
    
    
    @IBAction func buyBeer(_ sender: Any) {
        beerViewModel.buyAllBeer()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beerViewModel.beers.value.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "BeerViewController") as? BeerViewController else { return }
        destinationViewController.modalPresentationStyle = .fullScreen
        destinationViewController.beerViewModel.currentBeer.value = beerViewModel.beers.value[indexPath.item]
        destinationViewController.beerViewModel.index.value = indexPath.row
        present(destinationViewController, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.identifier) as? BeerCell else { return UITableViewCell()}
        cell.beerResult = beerViewModel.beers.value[indexPath.item]
        return cell
    }
}
