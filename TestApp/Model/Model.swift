//
//  AlbumsModel.swift
//  TestApp
//
//  Created by Sona on 20.04.24.
//

import Foundation

struct AlbumsModel : Codable {
    let userId: Int
    let id: Int
    let title: String
}

struct PhotoModel: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
