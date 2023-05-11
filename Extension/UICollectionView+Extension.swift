//
//  UICollectionView+Extension.swift
//  Anifu
//
//  Created by Terretino on 03/01/23.
//

import Foundation
import UIKit
import SkeletonView

class CollectionViewSkeletonDiffableDataSource<Section: Hashable, Item: Hashable>: UICollectionViewDiffableDataSource<Section, Item>, SkeletonCollectionViewDataSource {
    var cellIdentifier: String = "cell"
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension UICollectionView.CellRegistration {
    var cellProvider: (UICollectionView, IndexPath, Item) -> Cell {
        return { collectionView, indexPath, anime in
            collectionView.dequeueConfiguredReusableCell(
                using: self,
                for: indexPath,
                item: anime
            )
        }
    }
}
