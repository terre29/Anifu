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

class BrowseViewModel {
    let disposeBag = DisposeBag()
    
    var animeListViewModel = PublishSubject<TrendingAnimeList>()
    var forYouListModel = PublishSubject<TrendingAnimeList>()
    var thisSeasonModel = PublishSubject<TrendingAnimeList>()
    var upcomingSeasonModel = PublishSubject<TrendingAnimeList>()
    
    func getTopAnimeList(resource: Resource<JikanResponse>){
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] in
                self?.animeListViewModel.onNext(TrendingAnimeList(anime: $0.data))
            })
            .disposed(by: self.disposeBag)
    }
    
    func getForYouAnimeList(resource: Resource<JikanResponse>) {
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] in
                self?.forYouListModel.onNext(TrendingAnimeList(anime: $0.data))
            })
            .disposed(by: disposeBag)
    }
    
    func getThisAnimeList(resource: Resource<JikanResponse>) {
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
            URLRequest.load(resource: resource)
                .subscribe(onNext: { [weak self] in
                    self?.thisSeasonModel.onNext(TrendingAnimeList(anime: $0.data))
                })
                .disposed(by: self.disposeBag)
        })
    }
    
    func getUpcomingAnimeList(resource: Resource<JikanResponse>) {
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
            URLRequest.load(resource: resource)
                .subscribe(onNext: { [weak self] in
                    self?.upcomingSeasonModel.onNext(TrendingAnimeList(anime: $0.data))
                })
                .disposed(by: self.disposeBag)
        })
    }
    
    
    
    
}

extension AnimeCardModel {
    var title: Observable<String> {
        return Observable<String>.just(animeName)
    }
}
