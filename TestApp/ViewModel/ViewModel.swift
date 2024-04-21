//
//  ViewModel.swift
//  TestApp
//
//  Created by Sona on 21.04.24.
//

import Foundation


class ViewModel {
    
    func fetchAlbums(completion: @escaping ([AlbumsModel]) -> Void) {
        APIService.shared.fetchAlbums { albums in
            RealmManager.shared.saveAlbums(albums)
            completion(albums)
        }
    }
    
    func fetchPhotos(albumId: Int, completion: @escaping ([PhotoModel]) -> Void) {
        APIService.shared.fetchPhotos(albumId: albumId) { photos in
            RealmManager.shared.savePhotos(photos, albumId: albumId)
            completion(photos)
        }
    }
}
