//
//  AlbumsModel.swift
//  TestApp
//
//  Created by Sona on 20.04.24.
//

import Foundation
import RealmSwift

class AlbumsModel : Object, Codable {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
}

class PhotoModel: Object, Codable {
    @objc dynamic var albumId: Int = 0
    @objc  dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc  dynamic var url: String = ""
    @objc dynamic var thumbnailUrl: String = ""
}
