//
//  DataManager.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/2/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    
    static func queryPopular(page: Int, isMovie:Bool, completion: @escaping ([Movie], _ error:Error?) -> Void) {
        let realm = try! Realm()
        MoviesService.fetchPopular(page: page, isMovie: isMovie) { (movies, error) in
            if let movies = movies {
                for movie in movies {
                    movie.isPopular = true
                    movie.isMovie = isMovie
                    try! realm.write {
                        realm.create(Movie.self, value: movie, update: true)
                    }
                }
            }
            let predicate = NSPredicate(format: "isPopular == true AND isMovie == %@", NSNumber(value: isMovie))
            let popularMovies = realm.objects(Movie.self).filter(predicate)
            completion(Array(popularMovies), nil)
        }
    }
    
    static func queryTopRated(page: Int, isMovie:Bool, completion: @escaping ([Movie], _ error:Error?) -> Void) {
        let realm = try! Realm()
        MoviesService.fetchTopRated(page: page, isMovie: isMovie) { (movies, error) in
            if let movies = movies {
                for movie in movies {
                    movie.isTopRated = true
                    movie.isMovie = isMovie
                    try! realm.write {
                        realm.create(Movie.self, value: movie, update: true)
                    }
                }
            }
            let predicate = NSPredicate(format: "isTopRated == true AND isMovie == %@", NSNumber(value: isMovie))
            let popularMovies = realm.objects(Movie.self).filter(predicate)
            completion(Array(popularMovies), nil)
        }
    }
    
    static func queryUpcoming(page: Int, isMovie:Bool, completion: @escaping ([Movie], _ error:Error?) -> Void) {
        let realm = try! Realm()
        MoviesService.fetchUpcoming(page: page, isMovie: isMovie) { (movies, error) in
            if let movies = movies {
                for movie in movies {
                    movie.isUpcoming = true
                    movie.isMovie = isMovie
                    try! realm.write {
                        realm.create(Movie.self, value: movie, update: true)
                    }
                }
            }
            let predicate = NSPredicate(format: "isUpcoming == true AND isMovie == %@", NSNumber(value: isMovie))
            let popularMovies = realm.objects(Movie.self).filter(predicate)
            completion(Array(popularMovies), nil)
        }
    }
    
}
