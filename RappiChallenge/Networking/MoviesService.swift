//
//  MoviesService.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/1/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import Foundation
import Alamofire

class MoviesService: TMDbApiService {
    
    static let URL_POPULAR_MOVIE:String = "movie/popular"
    static let URL_POPULAR_SERIES:String = "tv/popular"
    static let URL_TOP_RATED_MOVIE:String = "movie/top_rated"
    static let URL_TOP_RATED_SERIES:String = "tv/top_rated"
    static let URL_COMING:String = "movie/upcoming"
    static let URL_ON_AIR:String = "tv/latest"
    
    static func fetchPopular(page: Int, isMovie:Bool, completion: @escaping (_ result: [Movie]?, _ error: String?) -> Void) {
        let url = isMovie ? URL_POPULAR_MOVIE : URL_POPULAR_SERIES
        query(page: page, path: url) { (movies, error) in
            completion(movies, error)
        }
    }
    
    static func fetchTopRated(page: Int, isMovie:Bool, completion: @escaping (_ result: [Movie]?, _ error: String?) -> Void) {
        let url = isMovie ? URL_TOP_RATED_MOVIE : URL_TOP_RATED_SERIES
        query(page: page, path: url) { (movies, error) in
            completion(movies, error)
        }
    }
    
    static func fetchUpcoming(page: Int, isMovie:Bool, completion: @escaping (_ result: [Movie]?, _ error: String?) -> Void) {
        let url =  isMovie ? URL_COMING : URL_ON_AIR
        query(page: page, path: url) { (movies, error) in
            completion(movies, error)
        }
    }
}
