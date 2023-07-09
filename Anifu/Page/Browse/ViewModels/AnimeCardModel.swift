//
//  AnimeCardModel.swift
//  Anifu
//
//  Created by Terretino on 15/12/22.
//

import Foundation
import RxSwift

struct TrendingAnimeList {
    let viewModel: [AnimeCardModel]
    let disposeBag = DisposeBag()
}

extension TrendingAnimeList {
    init(anime: [AnimeResponse]) {
        self.viewModel = anime.map({
            AnimeCardModel(animeName: $0.title, animeImageURL: $0.images.jpg.image_url, malId: $0.mal_id, isLoading: false)
        })
    }
}

struct AnimeCardModel: Hashable {
    static func == (lhs: AnimeCardModel, rhs: AnimeCardModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    let animeName: String
    let animeImageURL: String
    let malId: Int
    let isLoading: Bool
}

class BrowseViewModel: BrowseAnimeViewControllerBusinessLogic {
    
    let disposeBag = DisposeBag()
    
    weak var animeDetailPageRouter: Router?
    
    var animeListViewModel = PublishSubject<TrendingAnimeList>()
    var forYouListModel = PublishSubject<TrendingAnimeList>()
    var thisSeasonModel = PublishSubject<TrendingAnimeList>()
    var upcomingSeasonModel = PublishSubject<TrendingAnimeList>()
    
    var routeToAnimeDetail: () -> Void = {}
    var browseVCErrorHandler: (Error) -> Void = {_ in}
    
    func getTopAnimeList(resource: Resource<JikanResponse>){
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catch({ [weak self] error in
                self?.browseVCErrorHandler(error)
                return Observable.error(error)
            })
                .subscribe(onNext: { [weak self] in
                    self?.animeListViewModel.onNext(TrendingAnimeList(anime: $0.data))
                })
                    .disposed(by: self.disposeBag)
    }
    
    func getForYouAnimeList(resource: Resource<JikanResponse>) {
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catch({ [weak self] error in
                self?.browseVCErrorHandler(error)
                return Observable.error(error)
            })
                .subscribe(onNext: { [weak self] in
                    self?.forYouListModel.onNext(TrendingAnimeList(anime: $0.data))
                })
                    .disposed(by: self.disposeBag)
    }
    
    func getThisAnimeList(resource: Resource<JikanResponse>) {
        
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catch({ [weak self] error in
                self?.browseVCErrorHandler(error)
                return Observable.error(error)
            })
                .subscribe(onNext: { [weak self] in
                    self?.thisSeasonModel.onNext(TrendingAnimeList(anime: $0.data))
                })
                    .disposed(by: self.disposeBag)
                    
    }
    
    func getUpcomingAnimeList(resource: Resource<JikanResponse>) {
        
        URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catch({ [weak self] error in
                self?.browseVCErrorHandler(error)
                return Observable.error(error)
            })
                .subscribe(onNext: { [weak self] in
                    self?.upcomingSeasonModel.onNext(TrendingAnimeList(anime: $0.data))
                })
                    .disposed(by: self.disposeBag)
                    
    }
    
    func getForYouAnime() {
        let url = URL(string: URLConstant.shared.baseAnimeURL)!
            .appending("genres", value: "14")
            .appending("limit", value: "10")
            .appending("page", value: "1")
        let resource = Resource<JikanResponse>(url: url)
        getForYouAnimeList(resource: resource)
    }
    
    func getTrendingAnime() {
        let url = URL(string: URLConstant.shared.animeTopURL)!
            .appending("page", value: "1")
            .appending("limit", value: "10")
        let resource = Resource<JikanResponse>(url: url)
        getTopAnimeList(resource: resource)
    }
    
    func getUpcomingSeason() {
        let url = URL(string: URLConstant.shared.animeUpcomingSeasonURL)!
            .appending("limit", value: "10")
            .appending("page", value: "1")
        let resource = Resource<JikanResponse>(url: url)
        getUpcomingAnimeList(resource: resource)
    }
    
    func getThisSeason() {
        let url = URL(string: URLConstant.shared.animeThisSeasonURL)!
            .appending("limit", value: "10")
            .appending("page", value: "1")
        let resource = Resource<JikanResponse>(url: url)
        getThisAnimeList(resource: resource)
    }
    
}

extension AnimeCardModel {
    var title: Observable<String> {
        return Observable<String>.just(animeName)
    }
}
