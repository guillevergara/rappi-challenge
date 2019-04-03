//
//  Movie.swift
//  RappiChallenge
//
//  Created by Guillermo Vergara on 4/1/19.
//  Copyright © 2019 Guillermo Vergara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Movie: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var posterPath: String? = nil
    @objc dynamic var title: String? = nil
    @objc dynamic var overview: String? = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var isPopular: Bool = false
    @objc dynamic var isTopRated: Bool = false
    @objc dynamic var isUpcoming: Bool = false
    @objc dynamic var isMovie: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["title"]
    }
    
    private enum MovieCodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case name
        case posterPath = "poster_path"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
}
