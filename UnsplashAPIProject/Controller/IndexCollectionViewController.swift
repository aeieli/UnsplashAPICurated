//
//  IndexCollectionViewController.swift
//  UnsplashAPIProject
//
//  Created by lijingjing on 2018/9/21.
//  Copyright © 2018年 aeieli. All rights reserved.
//

import UIKit

import GTMRefresh
import Kingfisher
import Alamofire

private let reuseIdentifier = "IndexCollectionViewCell"


class IndexCollectionViewController: UICollectionViewController {
    
    var indexLayout: IndexCollectionViewFlowLayout = IndexCollectionViewFlowLayout()

    var imageList: [Photo] = []
    var imageKeyMap: [String: Photo] = [:]
    var limit: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.collectionViewLayout = indexLayout
        indexLayout.items = imageList
        self.collectionView.gtm_addRefreshHeaderView {
            [weak self] in
            print("excute refreshBlock")
            self?.refresh()

        }
        
        self.collectionView.gtm_addLoadMoreFooterView {
            [weak self] in
            print("excute loadMoreBlock")
            self?.loadMore()

        }
//
        refresh()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IndexCollectionViewCell
        let photo = imageList[indexPath.row]
        let url = URL(string: photo.urls.thumbUrl)
        cell.imageView.kf.setImage(with: url)
        
        // Configure the cell
    
        return cell
    }
    
    private func refresh() {
        imageList = []
        imageKeyMap = [:]
        loadMore()
    }
    
    private func loadMore() {
        var page: Int = 1
        if imageList.count > 0 {
            page += imageList.count / 10
        }
        UnsplashProvider.request(.curatedPhotos( page, limit)) { result in
            switch result {
            case let .success(response):
                do {
                    let body =  try response.mapJSON()
                    print(body)
                    let data = response.data
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let photos = try decoder.decode([Photo].self, from: data)
                    for  p in photos{
                        if !self.imageKeyMap.keys.contains(p.photoId) {
                            self.imageKeyMap[p.photoId] = p
                            self.imageList.append(p)
                        }
                    }
                    self.indexLayout.items = self.imageList
                    self.collectionView.reloadData()
                    self.collectionView.endRefreshing(isSuccess: true)
                    
                    self.collectionView.endLoadMore(isNoMoreData: self.imageList.count % 10 != 0)

                } catch {
                    print("error in this")
                    self.collectionView.endRefreshing(isSuccess: false)
                    
                    self.collectionView.endLoadMore(isNoMoreData: self.imageList.count % 10 != 0)
                }
                
            case let .failure(error):
                print(error)
            }
        }

    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
