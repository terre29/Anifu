//
//  TopAnimeModel.swift
//  Anifu
//
//  Created by Terretino on 03/01/23.
//

import Foundation
import RxSwift
import UIKit

struct AnimeListViewModel {
    let id: UUID = UUID()
    let animeList: [Anime]
}

struct Anime: Hashable {
    let anime: AnimeModel
}

struct AnimeModel: Hashable {
    let animeImageURL: URL?
    let name: String
    let score: String
    let year: String
    let status: String
    let ratings: String
}

extension AnimeListViewModel {
    init(anime: [AnimeResponse]) {
        self.animeList = anime.map({
            Anime(anime: .init(
                animeImageURL: URL(string:$0.url ?? ""),
                name: $0.title ?? "",
                score: "\($0.score)",
                year: "\($0.year)",
                status: $0.status ?? "",
                ratings: $0.status ?? "")
            )
        })
    }
}

extension Anime {
    var title: Observable<String> {
        return Observable<String>.just(anime.name)
    }
    
    var score: Observable<String> {
        return Observable<String>.just(anime.score)
    }
    
    var rating: Observable<String> {
        return Observable<String>.just(anime.ratings)
    }
    
    var year: Observable<String> {
        return Observable<String>.just(anime.year)
    }
    
    var status: Observable<String> {
        return Observable<String>.just(anime.status)
    }
}

enum TopAnimeSection: CaseIterable {
    case Top
}
