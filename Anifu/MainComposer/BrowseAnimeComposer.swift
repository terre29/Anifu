//
//  BrowseAnimeComposeer.swift
//  Anifu
//
//  Created by Terretino on 20/01/23.
//

import Foundation
import UIKit

struct BrowseAnimeComposer {
    static func makeBrowseAnimeViewController() -> BrowseAnimeViewController {
        let browseViewModel = BrowseViewModel()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        let browseAnimeViewControllerDependency = BrowseAnimeViewControllerDependency(
            dataSource: CollectionViewSkeletonDiffableDataSource(
                collectionView: collectionView,
                cellProvider: { cell, indexPath, model in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnimeCollectionViewCell
                    cell.model = model
                    return cell
                }),
            browseViewModel: browseViewModel,
            businessLogic: browseViewModel
        )
        
        let vc = BrowseAnimeViewController(dependency: browseAnimeViewControllerDependency)
        browseViewModel.browseVCErrorHandler = { [weak vc] error in
            vc?.browseViewControllerErrorHandler(error: error)
        }
        browseViewModel.routeToAnimeDetail = { dataNeeded in
            let animeDetailVM = AnimeDetailViewModel()
            let animeDetailVC = AnimeDetailPageComposer.createAnimeDetailViewController(viewModel: animeDetailVM)
            let animeDetailPageRouter = Router(sourceViewController: vc)
            animeDetailVC.hidesBottomBarWhenPushed = true
            animeDetailPageRouter.route(to: animeDetailVC, with: dataNeeded)
        }
        
        vc.title = "Browse"
        vc.collectionView = collectionView
        return vc
    }
}
