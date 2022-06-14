//
//  HomeViewController.swift
//  Cryptopy
//
//  Created by Ceren Yaşa on 12.06.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    @IBOutlet weak var coinTable: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var asset: Asset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidesWhenStopped = true
        
        coinTable.delegate = self
        coinTable.dataSource = self
        
        createViewModelStateChangeCompletion()
    }
    
    func createViewModelStateChangeCompletion(){
        viewModel.loadedCompletion = {
            if self.viewModel.state == PageState.loading{
                DispatchQueue.main.async {
                    self.spinner.startAnimating()
                }
            } else if self.viewModel.state == PageState.loaded {
                self.asset = self.viewModel.assets
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.coinTable.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asset?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coinTable.dequeueReusableCell(withIdentifier: "coinCell") as! CoinTableViewCell
        cell.coinLabel.text = asset?[indexPath.row].name ?? ""
        cell.coinPrice.text = String(asset?[indexPath.row].priceUsd ?? 0)
        //cell.coinImage.image = loadImage(url: asset[indexPath.row].assetID)
        return cell
    }
    
    @available(iOS 15.0.0, *)
    func loadImage(url: String) async -> UIImage {
        let imageURL = URL(string: url)!
        let request = URLRequest(url: imageURL)
        let (data, _) = try! await URLSession.shared.data(for: request, delegate: nil)
        return UIImage(data: data)!
    }
}
