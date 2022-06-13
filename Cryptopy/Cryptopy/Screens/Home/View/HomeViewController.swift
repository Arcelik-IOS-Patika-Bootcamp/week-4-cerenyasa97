//
//  HomeViewController.swift
//  Cryptopy
//
//  Created by Ceren Yaşa on 12.06.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidesWhenStopped = true
        
        createViewModelStateChangeCompletion()
    }
    
    func createViewModelStateChangeCompletion(){
        viewModel.loadedCompletion = {
            if self.viewModel.state == PageState.loading{
                DispatchQueue.main.async {
                    self.spinner.startAnimating()
                }
            } else if self.viewModel.state == PageState.loaded {
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                }
                print(self.viewModel.assets?.count ?? 0)
            }
        }
    }
}
