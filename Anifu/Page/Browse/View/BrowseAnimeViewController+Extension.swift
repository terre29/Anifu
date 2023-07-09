//
//  TrendingViewController+Extension.swift
//  Anifu
//
//  Created by Terretino on 04/01/23.
//

import Foundation
import UIKit
import RxSwift

extension BrowseAnimeViewController {
    func topAnimeDidLoad(model: TrendingAnimeList) {
        DispatchQueue.main.async { [weak self] in
            self?.dependency.dataSource.replaceItems(model.viewModel, in: .trending)
        }
    }
    
    func forYouAnimeDidLoad(model: TrendingAnimeList) {
        DispatchQueue.main.async { [weak self] in
            self?.dependency.dataSource.replaceItems(model.viewModel, in: .forYou)
        }

    }
    
    func thisSeasonAnimeDidLoad(model: TrendingAnimeList) {
        DispatchQueue.main.async { [weak self] in
            self?.dependency.dataSource.replaceItems(model.viewModel, in: .thisSeason)
        }
    }
    
    func upcomingSeasonAnimeDidLoad(model: TrendingAnimeList) {
        DispatchQueue.main.async { [weak self] in
            self?.dependency.dataSource.replaceItems(model.viewModel, in: .upcomingSeason)
        }
    }
    
    func makeGridLayoutSection() -> NSCollectionLayoutSection {
        // Each item will take up half of the width of the group
        // that contains it, as well as the entire available height:
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 8, trailing: 4)
        
        
        // Each group will then take up the entire available
        // width, and set its height to half of that width, to
        // make each item square-shaped:
        var group:  NSCollectionLayoutGroup?
        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.35)
                ),
                repeatingSubitem: item,
                count: 2
            )
        } else {
            // Fallback on earlier versions
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.35)
                ),
                subitem: item,
                count: 2
            )
        }
        group?.interItemSpacing = .fixed(8)
        let section = NSCollectionLayoutSection(group: group!)
        section.boundarySupplementaryItems = [makeHeaderSection()]
       
        return section
    }
    
    func makeListLayoutSection() -> NSCollectionLayoutSection {
        // Here, each item completely fills its parent group:
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 8, trailing: 4)
        // Each group then contains just a single item, and fills
        // the entire available width, while defining a fixed
        // height of 50 points:
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(140),
                heightDimension: .absolute(240)
            ),
            subitems: [item]
            )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [makeHeaderSection()]
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItem, offset, env) in
        }
        return section
        
    }
    
    func makeHeaderSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)),
                     elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    }
}

extension BrowseAnimeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        animeSearchBar.endEditing(true)
    }
}

extension BrowseAnimeViewController {
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, env in
            
            switch Section(rawValue: sectionIndex) {
            case .trending:
                return self?.makeListLayoutSection()
            case .forYou:
                return self?.makeListLayoutSection()
            case .thisSeason:
                return self?.makeListLayoutSection()
            case .upcomingSeason:
                return self?.makeListLayoutSection()
            default:
                return nil
            }
        }
    }
}

extension BrowseAnimeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? AnimeCollectionViewCell else { return }
        if let image = cell.animeImageCache.object(forKey: NSNumber(value: cell.model.malId)) {
            cell.animeImageCapturedData.accept(image)
        } else {
            cell.getImage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dependency.browseViewModel.routeToAnimeDetail()
    }
}

extension BrowseAnimeViewController {
    enum Section: Int, CaseIterable {
        case trending
        case forYou
        case thisSeason
        case upcomingSeason
    }
    
    func makeDataSource() -> CollectionViewSkeletonDiffableDataSource<Section, AnimeCardModel> {
        return CollectionViewSkeletonDiffableDataSource(
            collectionView: collectionView,
            cellProvider: makeRegistration().cellProvider)
    }
    
    
    typealias CellRegistration = UICollectionView.CellRegistration<AnimeCollectionViewCell, AnimeCardModel>
    
    func makeRegistration() -> CellRegistration {
        CellRegistration { cell, indexPath, model in
            cell.model = model
        }
    }
}

extension UICollectionViewDiffableDataSource {
    func replaceItems(_ items : [ItemIdentifierType], in section: SectionIdentifierType) {
        var currentSnapshot = snapshot()
        let itemsOfSection = currentSnapshot.itemIdentifiers(inSection: section)
        currentSnapshot.deleteItems(itemsOfSection)
        currentSnapshot.appendItems(items, toSection: section)
        currentSnapshot.reloadSections([section])
        apply(currentSnapshot, animatingDifferences: true)
    }
}
