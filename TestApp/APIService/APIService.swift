//
//  APIService.swift
//  TestApp
//
//  Created by Sona on 21.04.24.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    private init() {}
        
    func fetchAlbums(completion: @escaping ([AlbumsModel]) -> Void) {
        let task = URLSession.shared.dataTask(with: RequestType.getAlbums.url) {(data, response, error) in
            if error != nil {
                completion([])
                return
            }
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([AlbumsModel].self, from: data)
                completion(decodedData)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
    
    func fetchPhotos(albumId: Int, completion: @escaping ([PhotoModel]) -> Void) {
        let task = URLSession.shared.dataTask(with: RequestType.getPhotos(albumId).url) {(data, response, error) in
            if error != nil {
                completion([])
                return
            }
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([PhotoModel].self, from: data)
                completion(decodedData)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}


enum RequestType {
    case getAlbums
    case getPhotos(Int)
    
    private var stringValue: String {
        switch self {
        case .getAlbums:
            return baseApi + "/albums"
        case .getPhotos(let albumId):
            return baseApi + "/photos?albumId=\(albumId)"
        }
    }
    
    var url: URL {
        if let url = URL(string: stringValue) {
            return url
        }
        return URL(fileURLWithPath: "")
    }
    
    private var baseApi: String {
        return  "https://jsonplaceholder.typicode.com"
    }
}
