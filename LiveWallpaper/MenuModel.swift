//
//  MenuModel.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 26/12/22.
//

import Foundation

struct MainModel: Codable {
    var new, menu: [Menu]?
}

struct Menu: Codable {
    var id: Int?
    var name: String?
    var menuDescription: String?
    var isNew: Int?
    var imageThumb, imageBackground: String?
    var orderOf: Int?
    var createdAt: String?
    var updatedAt: String?
    var subCategory: [Menu]?
    var categoryID, isMenu: Int?

 
}
