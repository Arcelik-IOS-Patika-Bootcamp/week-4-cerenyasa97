//
//  HomeService.swift
//  Cryptopy
//
//  Created by Ceren Yaşa on 9.06.2022.
//

import Foundation

protocol HomeServiceProtocol{
    func getAsset(completion:@escaping (Asset?) -> Void)
}

class HomeService: HomeServiceProtocol{
    func getAsset(completion: @escaping (Asset?) -> Void) {
        let service = APIService<Asset>()
        service.getData(endPoint: CoinEndpoint.assetsEndPoint.rawValue){objects in
            completion(objects)
        }
    }
}
