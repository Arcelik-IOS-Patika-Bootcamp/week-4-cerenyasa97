//
//  HomeViewModel.swift
//  Cryptopy
//
//  Created by Ceren Yaşa on 11.06.2022.
//

import Foundation

enum PageState{
    case initial, loading, loaded, error
}

class HomeViewModel: NSObject {
    
    let service: HomeService = HomeService()
    var assets: Asset?
    var loadedCompletion: (() -> Void)?{
        didSet{
            fetchData()
        }
    }
    var state: PageState? {
        didSet {
            if let stateChangeCompletion = loadedCompletion{
                stateChangeCompletion()
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    func fetchData(){
        state = PageState.loading
        fetchAssets()
        fetchCoinExchanges()
    }
    
    func fetchAssets(){
        service.getAsset { assets in
            self.assets = assets
            self.state = PageState.loaded
        }
    }
    
    func fetchCoinExchanges(){
        
    }
}
