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
    var vm: AlbumViewModel = AlbumViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.separatorStyle = .none
        bindingViewModel()
    }
    
    private func bindingViewModel(){
        vm.fetchAlbums {[weak self] data in
            self?.update(data: data)
        }
    }
    
    private func update(data: [AlbumsModel]){
        albumList = data
        DispatchQueue.main.async {
            self.photoTableView.reloadData()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photoTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.configUI(photo: photos[albumList[indexPath.section].id] ?? [])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return albumList[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
