//
//  ViewController.swift
//  TestApp
//
//  Created by Sona on 18.04.24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var photoTableView: UITableView!
    
    var albumList: [AlbumsModel] = []
    
    var photos: [Int: [PhotoModel]] = [:]
    var vm: ViewModel = ViewModel()
    

    var totalElements = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.separatorStyle = .none
        bindingViewModel()
    }
    
    private func bindingViewModel(){
        albumList = RealmManager.shared.getSavedAlbums()
        totalElements = albumList.count
        if albumList.isEmpty {
            vm.fetchAlbums {[weak self] data in
                DispatchQueue.main.async {
                    self?.albumList = data
                    self?.totalElements = data.count
                    self?.getPhotos()
                }
            }
        }else{
            let localPhotos = RealmManager.shared.getSavedPhotos()
            
            if localPhotos.isEmpty {
                getPhotos()
            }else{
                for album in localPhotos {
                    photos[album.albumId] = Array(album.photos)
                }
                updateTableView()
            }
        }
    }
    
    
    private func updateTableView(){
        DispatchQueue.main.async {
            self.photoTableView.reloadData()
        }
    }
    
    private func getPhotos(){
        let group = DispatchGroup()
        
        for alb in albumList {
            group.enter()
            
            vm.fetchPhotos(albumId: alb.id) { [weak self] data in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.photos[alb.id] = data
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.updateTableView()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
                return totalElements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photoTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.configUI(photo: photos[albumList[indexPath.section % albumList.count].id] ?? [])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentCell = section % albumList.count
        return albumList[currentCell].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Calculate the index path of the last visible cell
        guard let lastVisibleIndexPath = photoTableView.indexPathsForVisibleRows?.last else {
            return
        }
        
        if lastVisibleIndexPath.section == totalElements - 1 {
            totalElements +=  albumList.count
            photoTableView.reloadData()
        }
    }
}
