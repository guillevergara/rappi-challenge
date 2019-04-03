//
//  TMDbApiService.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/1/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import Foundation
import Alamofire

class TMDbApiService {
    
    static func query(page: Int, path:String, completion: @escaping (_ result: [Movie]?, _ error: String?) -> Void) {
        
        do{
            let sessionManager = Alamofire.SessionManager.default
            let parameters: Parameters = getParameters(page: page)
            let urlRequest = try request(parameters: parameters, path: path)
            sessionManager.request(urlRequest).responseJSON { response in
                if response.result.isSuccess {
                    let json = response.data
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                        let result = try decoder.decode(MovieResponse.self, from: json!)
                        completion(result.results, nil)
                    } catch let error {
                        completion(nil, error.localizedDescription)
                    }
                } else if let error = response.error, error._code == -1009 {
                    completion(nil, error.localizedDescription)
                } else {
                    completion(nil, response.result.error!.localizedDescription)
                }
            }
        }catch let error{
            print(error)
        }
    }
    
    static func getParameters(page:Int) -> Parameters{
        let apiKey = Bundle.main.infoDictionary!["serviceApiKey"] as! String
        let dicRequest = ["page" : page, "api_key" : apiKey] as [String : Any]
        return dicRequest
    }
    
    static func request(parameters:Parameters, path:String) throws -> URLRequest {
        let baseUrl = Bundle.main.infoDictionary!["serviceUrl"] as! String
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        return urlRequest
    }
}
