//
//  RealmSwift.swift
//  TestApp
//
//  Created by Sona on 21.04.24.
//

import Foundation
import RealmSwift

class AlbumWithPhotos: Object {
        @objc dynamic var albumId: Int = 0
        let photos = List<PhotoModel>()

        override static func primaryKey() -> String? {
            return "albumId"
        }
    }


final class RealmManager {
    static let shared = RealmManager()

    private let realm: Realm = try! Realm()
    
    private lazy var albums: Results<AlbumsModel> = {realm.objects(AlbumsModel.self) }()


    private init() {}

    func saveAlbums(_ albums: [AlbumsModel]) {
        DispatchQueue.main.async {
            try! self.realm.write{
                self.realm.add(albums)
            }
        }
    }

    func savePhotos(_ photos: [PhotoModel], albumId: Int) {
        DispatchQueue.main.async {
               try! self.realm.write {
                   if let album = self.realm.object(ofType: AlbumWithPhotos.self, forPrimaryKey: albumId) {
                       album.photos.removeAll()
                       album.photos.append(objectsIn: photos)
                   } else {
                       let album = AlbumWithPhotos()
                       album.albumId = albumId
                       album.photos.append(objectsIn: photos)
                       self.realm.add(album)
                   }
               }
           }
    }

    func getSavedAlbums() -> [AlbumsModel] {
        return Array(self.realm.objects(AlbumsModel.self))
    }

    func getSavedPhotos() -> [AlbumWithPhotos] {
        return Array(self.realm.objects(AlbumWithPhotos.self))
        }
    
}
