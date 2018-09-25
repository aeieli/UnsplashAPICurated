//
//  IndexCollectionViewFlowLayout.swift
//  UnsplashAPIProject
//
//  Created by lijingjing on 2018/9/22.
//  Copyright © 2018年 aeieli. All rights reserved.
//

import UIKit

protocol IndexCollectionViewFlowLayoutDelegate {
    func collection(_ collectionView: UICollectionView, flowLayout layout: UICollectionViewLayout, heightForItemAt indxePath: IndexPath) -> CGFloat
}


class IndexCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var items = [Photo]()

    fileprivate lazy var layoutAttributes: [UICollectionViewLayoutAttributes] = {
        return [UICollectionViewLayoutAttributes]()
    }()
    
    
    override func prepare() {
        super.prepare()
        
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        
        
        let contentWidth:CGFloat = collectionView!.bounds.size.width - sectionInset.left - sectionInset.right
        let itemWidth = (contentWidth - minimumInteritemSpacing ) / 2.0
        
        // 計算cell的佈局
        self.computeAttributes(itemWidth:CGFloat(itemWidth))

    }
    
    fileprivate func computeAttributes(itemWidth:CGFloat) {
        
        // 以sectionInset.top作為最初始的高度，紀錄每一個column的高度
        var columnHeights = [CGFloat](repeating: sectionInset.top, count: 2)
        
        // 記錄每一個column的item個數
        var columnItemCount = [Int](repeating: 0, count: 2)
        
        // 紀錄每一個cell的attributes
        var attributes = [UICollectionViewLayoutAttributes]()
        
        var row = 0
        for item in items {
            // 建立一個attribute
            let indexPath = IndexPath.init(row: row, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 找出最短的Column
            let minHeight = columnHeights.sorted().first!
            let minHeightColumn = columnHeights.index(of: minHeight)!
            
            // 新的照片放到最短Column上
            columnItemCount[minHeightColumn] += 1
            let itemX = (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightColumn) + sectionInset.left
            let itemY = minHeight
            
            // 計算高度，按照原圖片大小等比例縮放
            let itemHeight = CGFloat(item.height) * itemWidth / CGFloat(item.width)
            
            // 設定Frame，加入到attributes中
            attribute.frame = CGRect(x: itemX, y: CGFloat(itemY), width: itemWidth, height: CGFloat(itemHeight))
            attributes.append(attribute)
            
            // 計算最短的column當前的高度
            columnHeights[minHeightColumn] += itemHeight + minimumLineSpacing
            
            row += 1
        }
        
        // 找出最高的Column
        let maxHeight = columnHeights.sorted().last!
        let column = columnHeights.index(of: maxHeight)
        
        // 用於系統計算collectionView的contentSize - 根據最高的Column來設置itemSize，使用總高度的平均值
        let itemHeight = (maxHeight - minimumLineSpacing * CGFloat(columnItemCount[column!])) / CGFloat(columnItemCount[column!])
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        self.layoutAttributes = attributes
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
}
