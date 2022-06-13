//
//  AppConstants.swift
//  Cryptopy
//
//  Created by Ceren Yaşa on 9.06.2022.
//

import Foundation

class AppConstants{
    static let baseURL: String = "https://rest.coinapi.io/"
    static let apiKey: String = "B7B4748F-703E-4329-AB4B-4CA07C6B5714"
    static let apiKeyKey: String = "X-CoinAPI-Key"
    static let contentType: String = "Content-Type"
    static let contentTypeValue: String = "application/json"
}

enum CoinEndpoint: String{
    case assetsEndPoint = "v1/assets"
}
