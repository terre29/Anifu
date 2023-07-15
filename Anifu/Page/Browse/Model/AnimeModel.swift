//
//  AnimeModel.swift
//  Anifu
//
//  Created by Terretino on 29/12/22.
//

import Foundation
import UIKit
import RxSwift

enum BrowseAnimeSection: Int, CaseIterable {
    case trending
    case forYou
    case thisSeason
    case upcomingSeason
}

struct BrowseAnimeViewControllerDependency {
    let dataSource: CollectionViewSkeletonDiffableDataSource<BrowseAnimeSection, AnimeCardModel>
    let browseViewModel: BrowseViewModel
    var businessLogic: BrowseAnimeViewControllerBusinessLogic
}

struct JikanResponse: Decodable {
    let data: [AnimeResponse]
}

struct AnimeHeader: Hashable {
    let title: String
}


struct AnimeResponse: Decodable, Hashable {
    let mal_id: Int
    let url: String
    let title: String
    let title_english: String?
    let title_japanese: String?
    let images: ImagesResponse
    let rating: String?
    let score: Double?
    let status: String
    let year: Int?
    let type: String
    let synopsis: String
    let background: String?
    let rank: Int?
    let aired: AiredStatus
}

struct ImagesResponse: Decodable, Hashable {
    let jpg: ImageJpgResponse
}

struct AiredStatus: Decodable, Hashable {
    let from: Date?
    let to: Date?
}

struct ImageJpgResponse: Decodable, Hashable {
    let image_url: String
    let small_image_url: String
    let large_image_url: String
}

struct SectionList {
    static let sectionList = ["Top Anime", "Recommended for You", "This Season Anime", "Upcoming Anime"]
}
