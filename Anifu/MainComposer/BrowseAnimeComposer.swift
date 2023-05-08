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
            getTopAnime: {
                let url = URL(string: URLConstant.shared.animeTopURL)!
                    .appending("limit", value: "5")
                    .appending("page", value: "0")
                let resource = Resource<JikanResponse>(url: url)
                browseViewModel.getTopAnimeList(resource: resource)
            },
            getThisSeasonAnime: {
                let url = URL(string: URLConstant.shared.animeThisSeasonURL)!
                    .appending("limit", value: "10")
                    .appending("page", value: "0")
                let resource = Resource<JikanResponse>(url: url)
                browseViewModel.getThisAnimeList(resource: resource)
            },
            getUpcomingSeasonAnime: {
                let url = URL(string: URLConstant.shared.animeUpcomingSeasonURL)!
                    .appending("limit", value: "10")
                    .appending("page", value: "0")
                let resource = Resource<JikanResponse>(url: url)
                browseViewModel.getUpcomingAnimeList(resource: resource)
            },
            getForYouAnime: {
                let url = URL(string: URLConstant.shared.baseAnimeURL)!
                    .appending("genres", value: "14")
                    .appending("limit", value: "10")
                    .appending("page", value: "0")
                let resource = Resource<JikanResponse>(url: url)
                browseViewModel.getForYouAnimeList(resource: resource)
            })
        let vc = BrowseAnimeViewController(dependency:browseAnimeViewControllerDependency)
        vc.collectionView = collectionView
        return vc
    }
}
