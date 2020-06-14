//
//  BaseParse.swift
//  HeadyTst
//
//  Created by Rohan Deshmukh on 13/06/20.
//  Copyright © 2020 RohanDeshmukh. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

// MARK: - ResultBaseParser
@objcMembers class ResultBaseParser: Codable {
    dynamic var categories: [Category]?
    dynamic var rankings: [Ranking]?
    
    init(categories: [Category]?, rankings: [Ranking]?) {
        self.categories = categories
        self.rankings = rankings
    }
}

// MARK: - Category
@objcMembers class Category: Object, Codable {
    dynamic var id: Int?
    dynamic var name: String?
    dynamic var products: List<CategoryProduct>?
    dynamic var childCategories: List<Int>?
    
    enum CodingKeys: String, CodingKey {
        case id, name,products
        case childCategories = "child_categories"
    }
    
    convenience init(id: Int?, name: String?, products: List<CategoryProduct>?, childCategories: List<Int>?) {
        self.init()
        self.id = id
        self.name = name
        self.products = products
        self.childCategories = childCategories
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - CategoryProduct
@objcMembers class CategoryProduct: Object, Codable {
    dynamic var id: Int? = 0
    dynamic var name, dateAdded: String?
    dynamic var variants: [Variant]?
    dynamic var tax: Tax?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case dateAdded = "date_added"
        case variants, tax
    }
    
    convenience init(id: Int?, name: String?, dateAdded: String?, variants: [Variant]?, tax: Tax?) {
        self.init()
        self.id = id
        self.name = name
        self.dateAdded = dateAdded
        self.variants = variants
        self.tax = tax
    }
    
    required convenience init(from decoder: Decoder) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Tax
@objcMembers class Tax: Object, Codable {
    dynamic var name: String?
    dynamic var value: Double?
    
    convenience init(name: String?, value: Double?) {
        self.init()
        self.name = name
        self.value = value
    }
    
    required convenience init(from decoder: Decoder) {
        self.init()
    }
}

//enum Name: String, Codable {
//    case vat = "VAT"
//    case vat4 = "VAT4"
//}

// MARK: - Variant
@objcMembers class Variant: Object, Codable {
    dynamic var id: Int? = 0
    dynamic var color: String?
    dynamic var size: Int?
    dynamic var price: Int?
    
    convenience init(id: Int?, color: String?, size: Int?, price: Int?) {
        self.init()
        self.id = id
        self.color = color
        self.size = size
        self.price = price
    }
    
    required convenience init(from decoder: Decoder) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Ranking
@objcMembers class Ranking: Object, Codable {
    dynamic var ranking: String?
    dynamic var products: [RankingProduct]?
    
    convenience init(ranking: String?, products: [RankingProduct]?) {
        self.init()
        self.ranking = ranking
        self.products = products
    }
    
    required convenience init(from decoder: Decoder) {
        self.init()
    }
}

// MARK: - RankingProduct
@objcMembers class RankingProduct: Object, Codable {
    dynamic var id: Int?
    dynamic var viewCount, orderCount, shares: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shares
    }
    
    convenience init(id: Int?, viewCount: Int?, orderCount: Int?, shares: Int?) {
        self.init()
        self.id = id
        self.viewCount = viewCount
        self.orderCount = orderCount
        self.shares = shares
    }
    
    required convenience init(from decoder: Decoder) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
