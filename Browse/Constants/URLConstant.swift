//
//  URLConstant.swift
//  Anifu
//
//  Created by Terretino on 09/01/23.
//

import Foundation

public struct URLConstant {
    public static var shared = URLConstant()
    
    public let baseURL = "https://api.jikan.moe/v4"
    public let baseAnimeURL = "https://api.jikan.moe/v4/anime"
    public let animeRecommendationURL = "https://api.jikan.moe/v4/recommendations/anime"
    public let animeThisSeasonURL = "https://api.jikan.moe/v4/seasons/now"
    public let animeUpcomingSeasonURL = "https://api.jikan.moe/v4/seasons/upcoming"
    public let animeTopURL = "https://api.jikan.moe/v4/top/anime"
}
