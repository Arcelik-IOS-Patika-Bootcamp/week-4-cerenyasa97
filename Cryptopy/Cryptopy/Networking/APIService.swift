//
//  APIService.swift
//  Cryptopy
//
//  Created by Ceren Yaşa on 9.06.2022.
//

import Foundation

class APIService<T: Codable>{
    
    let baseURL = AppConstants.baseURL
    
    fileprivate func createRequest(endPoint: String) -> URLRequest? {
        if let url = URL(string: baseURL + endPoint){
            var request = URLRequest(url: url)
            request.setValue(AppConstants.apiKey, forHTTPHeaderField: AppConstants.apiKeyKey)
            request.setValue(AppConstants.contentTypeValue, forHTTPHeaderField: AppConstants.contentType)
            return request
        }
        else {
            print("URL was called on null")
        }
        return nil
    }
    
    func getData(endPoint: String, completion:@escaping (T?) -> Void) {
        if let request = self.createRequest(endPoint: endPoint) {
            urlSession(request, completion)
        } else {
            completion(nil)
            print("Request could not be created")
        }
    }
    
    func postData(endPoint: String, postString: String, completion:@escaping (T?) -> Void){
        if var request = self.createRequest(endPoint: endPoint) {
            request.httpMethod = "POST"
            
            request.httpBody = postString.data(using: .utf8)
            
            urlSession(request, completion)
        } else {
            completion(nil)
            print("Request could not be created")
        }
    }
    
    fileprivate func urlSession(_ request: URLRequest, _ completion:@escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: request){ data, response, error in
            if error != nil {
                showMessage(title: Strings.error, text: Error.connectionError.rawValue, isJustConfirm: true)
                completion(nil)
                return
            } else if data == nil {
                completion(nil)
                showMessage(title: Strings.error, text: Error.noDataError.rawValue, isJustConfirm: true)
                return
            }
            
            if let data = data {
                let objectData = self.parseData(data: data)
                completion(objectData)
            }
        }.resume()
    }

    fileprivate func parseData(data: Data) -> T? {
        do{
            let objects = try JSONDecoder().decode(T.self, from: data)
            return objects
        } catch {
            showMessage(title: Strings.error, text: Error.parseError.rawValue, isJustConfirm: true)
            return nil
        }
    }
}
