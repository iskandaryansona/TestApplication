//
//  ViewModel.swift
//  TestApp
//
//  Created by Sona on 21.04.24.
//

import Foundation


class AlbumViewModel {
    
    func fetchAlbums(completion: @escaping ([AlbumsModel]) -> Void) {
        APIService.shared.fetchAlbums { albums in
            completion(albums)
        }
    }
}


class PhotoViewModel {
    
    func fetchPhotos(albumId: Int, completion: @escaping ([PhotoModel]) -> Void) {
        APIService.shared.fetchPhotos(albumId: albumId) { photos in
            completion(photos)
        }
    }
}
