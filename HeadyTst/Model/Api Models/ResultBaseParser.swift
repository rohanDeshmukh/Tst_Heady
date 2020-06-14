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
    
    dynamic var id: Int = 0
    dynamic var name: String?
    
    var products = List<CategoryProduct>()
    var childCategories = List<Int>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case products
        case childCategories = "child_categories"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let prodList = try container.decodeIfPresent([CategoryProduct].self, forKey: .products) ?? [CategoryProduct()]
        products.append(objectsIn: prodList)
        let chlidCateList = try container.decodeIfPresent([Int].self, forKey: .childCategories) ?? [Int()]
        childCategories.append(objectsIn: chlidCateList)
    }
}

// MARK: - CategoryProduct
@objcMembers class CategoryProduct: Object, Codable {
    dynamic var id: Int = 0
    dynamic var name, dateAdded: String?
    var variants = List<Variant>()
    dynamic var tax: Tax?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case dateAdded = "date_added"
        case variants, tax
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.dateAdded = try container.decodeIfPresent(String.self, forKey: .dateAdded)
        let variantList = try container.decodeIfPresent([Variant].self, forKey: .variants) ?? [Variant()]
        variants.append(objectsIn: variantList)
        self.tax = try container.decodeIfPresent(Tax.self, forKey: .tax)
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
    dynamic var id: Int = 0
    dynamic var color: String?
    dynamic var size: Int?
    dynamic var price: Int?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        self.size = try container.decodeIfPresent(Int.self, forKey: .size)
        self.price = try container.decodeIfPresent(Int.self, forKey: .price)
    }
    
}

// MARK: - Ranking
@objcMembers class Ranking: Object, Codable {
    dynamic var ranking: String?
    var products =  List<RankingProduct>()
    
    enum CodingKeys: String, CodingKey {
        case ranking, products
    }
    
    override class func primaryKey() -> String? {
        return "ranking"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ranking = try container.decode(String.self, forKey: .ranking)
        let productList = try container.decodeIfPresent([RankingProduct].self, forKey: .products) ?? [RankingProduct()]
        products.append(objectsIn: productList)
        
    }
}

// MARK: - RankingProduct
@objcMembers class RankingProduct: Object, Codable {
    dynamic var id: Int = 0
    dynamic var viewCount, orderCount, shares: Int?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shares
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.viewCount = try container.decodeIfPresent(Int.self, forKey: .viewCount)
        self.orderCount = try container.decodeIfPresent(Int.self, forKey: .orderCount)
        self.shares = try container.decodeIfPresent(Int.self, forKey: .shares)
    }
    
    
}
