//
//  ModelViewController.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 19/12/22.
//

import Foundation

struct BaseModel: Codable {
    var banner: [Banner]?
    var categories: [Category]?

}


struct Banner: Codable {
    var id, category_id: Int?
    var image, created_at, updated_at: String?

}


struct Category: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var is_new: Int?
    var image_thumb, image_background: String?
    var order_of: Int?
    var created_at, updated_at: String?
    var images: [Image]?

}


class Image: Codable {
    var id, category_id, sub_category_id: Int?
    var image_thumb, created_at, updated_at: String?
    var image_main, image_placeholder, image_lockScreen, image_homeScreen: String?
    var type: String?

    

}

//struct ToDo: Codable {
//  let userId: Int
//  let id: Int
//  let title: String
//  let completed: Bool
//}

//struct Data{
//    let sectionType: String
//    let images: [String]
//}

//class ToDoClass {
//    var userID: Int
//    var id: Int
//    var title: String
//    var completed: Bool
//    init(userID: Int, id: Int, title: String) {
//        self.userID = userID
//        self.id = id
//        self.title = title
//        self.completed = true
//
//    }
//
//}







