//
//  TrendingViewController.swift
//  Anifu
//
//  Created by Terretino on 15/12/22.
//

import Foundation
import UIKit
import SwiftUI
import SkeletonView
import RxSwift

protocol BrowseAnimeViewControllerBusinessLogic {
    func getForYouAnime()
    func getTrendingAnime()
    func getUpcomingSeason()
    func getThisSeason()
}

class BrowseAnimeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        return collectionView
    }()
    
    lazy var animeSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search anime here"
        return searchBar
    }()
    
    
    var dependency: BrowseAnimeViewControllerDependency
    var isShowingError: Bool = false
    var errorVC: UIViewController?
    let disposeBag = DisposeBag()
    
    init(dependency: BrowseAnimeViewControllerDependency) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<BrowseAnimeSection, AnimeCardModel>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Browse"
        registerSkeleton()
        headerRegistration()
        setupPage()
        createView()
        setupCollectionView()
        bindAnimeData()
        applyFirstSnapshotSection()
        getTrendingAnime()
        getForYouAnime()
        getThisSeason()
        getUpcomingSeason()
        subscribeSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func applyFirstSnapshotSection() {
        snapshot.appendSections(BrowseAnimeSection.allCases)
        BrowseAnimeSection.allCases.forEach({
            let emptyAnimeData =  AnimeData(rating: "", score: 0, scoredBy: 0, type: "", status: "", background: "", synopsys: "", rank: 0, aired: Date(), titleJp: "", titleEng: "")
            snapshot.appendItems([AnimeCardModel(animeName: "", animeImageURL: "", malId: 0, isLoading: true, animeData: emptyAnimeData), AnimeCardModel(animeName: "", animeImageURL: "", malId: 0, isLoading: true, animeData: emptyAnimeData), AnimeCardModel(animeName: "", animeImageURL: "", malId: 0, isLoading: true, animeData: emptyAnimeData), AnimeCardModel(animeName: "", animeImageURL: "", malId: 0, isLoading: true, animeData: emptyAnimeData), AnimeCardModel(animeName: "", animeImageURL: "", malId: 0, isLoading: true, animeData: emptyAnimeData)], toSection: $0)
        })
        dependency.dataSource.apply(snapshot)
    }
    
    func bindAnimeData() {
        dependency.browseViewModel.animeListViewModel
            .subscribe(onNext: { [weak self] model in
                self?.topAnimeDidLoad(model: model)
            },
            onError: { [weak self] error in
                self?.browseViewControllerErrorHandler(error: error)
            })
            .disposed(by: disposeBag)

        dependency.browseViewModel.forYouListModel
            .catch({ [weak self] error in
                self?.browseViewControllerErrorHandler(error: error)
                return Observable.empty()
            })

            .subscribe(onNext: { [weak self] model in
                self?.forYouAnimeDidLoad(model: model)
            })
            .disposed(by: disposeBag)

        dependency.browseViewModel.thisSeasonModel
            .subscribe(onNext: { [weak self] model in
                self?.thisSeasonAnimeDidLoad(model: model)
            },
            onError: { [weak self] error in
                self?.browseViewControllerErrorHandler(error: error)
            })
            .disposed(by: disposeBag)

        dependency.browseViewModel.upcomingSeasonModel
            .subscribe(onNext: { [weak self] model in
                self?.upcomingSeasonAnimeDidLoad(model: model)
            },
            onError: { [weak self] error in
                self?.browseViewControllerErrorHandler(error: error)
            })
            .disposed(by: disposeBag)
    }

    func getForYouAnime() {
        dependency.businessLogic.getForYouAnime()
    }
    
    func getTrendingAnime() {
        dependency.businessLogic.getTrendingAnime()
    }
    
    func getThisSeason() {
        dependency.businessLogic.getThisSeason()
    }
    
    func getUpcomingSeason() {
        dependency.businessLogic.getUpcomingSeason()
    }
    
    func setupPage() {
        let searchBar = UIBarButtonItem(customView: animeSearchBar)
        searchBar.customView?.sizeToFit()
        animeSearchBar.delegate = self
        navigationItem.leftBarButtonItem = searchBar
    }
    
    func createView() {
        view.addSubview(collectionView)
        collectionView.pinToAllSides(to: view)
    }
    
    func subscribeSearchBar() {
//        animeSearchBar.rx.searchButtonClicked
//            .map { [weak self] in
//                self?.animeSearchBar.text
//            }
//            .subscribe(onNext: { [weak self] wordQ in
//                guard let wordQ = wordQ else {
//                    print("asdasdasd")
//                    return
//                }
//                self?.searchAnime(keyWord: wordQ)
//
//            })
//            .disposed(by: disposeBag)
    }
    
    func setupCollectionView() {
        collectionView.register(AnimeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(AnimeCustomSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "head")
        collectionView.dataSource = self.dependency.dataSource
        collectionView.delegate = self
        self.collectionView.collectionViewLayout = makeCollectionViewLayout()
    }
    
    func registerSkeleton() {
        collectionView.isSkeletonable = true
    }
    
    func headerRegistration() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <AnimeCustomSectionHeader>(elementKind: UICollectionView.elementKindSectionHeader) {
            (headerView, elementKind, indexPath) in
            headerView.sectionTitle.text = SectionList.sectionList[indexPath.section]
        }
        dependency.dataSource.supplementaryViewProvider = { [weak self] (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(
                   using: headerRegistration, for: indexPath)
        }
    }
    
    func browseViewControllerErrorHandler(error: Error) {
        guard !isShowingError else { return }
        isShowingError = true
        let errorVC = AnifuErrorViewController(reloadAction: { [weak self] in
            guard let self else { return }
            bindAnimeData()
            getTrendingAnime()
            getForYouAnime()
            getThisSeason()
            getUpcomingSeason()
            self.errorVC?.view.removeFromSuperview()
            self.errorVC?.removeFromParent()
            isShowingError = false
        })
        if self.errorVC == nil {
            self.errorVC = errorVC
        }
        addChild(self.errorVC!)
        view.addSubview(self.errorVC!.view)
        self.errorVC!.view.pinToAllSides(to: view)
    }
}
