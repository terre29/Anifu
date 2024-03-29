//
//  AnimeDetailModel.swift
//  Anifu
//
//  Created by Indocyber on 27/05/23.
//

import Foundation
import UIKit

struct AnimeDetailDependency {
    let animeImage: UIImage
    let animeRating: String
    let animeRanking: String
    let animeTitle: String
    let animeType: String
    let animeAired: Date
    let animeScore: Double
    let animeScoreBy: Int
    let sysnopsis: String
    let titles: AnimeTitle
}

struct AnimeTitle {
    let original: String
    let english: String
    let japanese: String
}

enum DisplayedTitle {
    case Eng
    case Jpn
    case Oth
}


@available(iOS 15.0, *)
extension UIButton.Configuration {
    static func configEngNameButton(isSelected: Bool) -> UIButton.Configuration {
        var configuration  = isSelected ? UIButton.Configuration.filled() : UIButton.Configuration.bordered()
        configuration.title = "EN"
        return configuration
    }
    
    static func configJpnNameButton(isSelected: Bool) -> UIButton.Configuration {
        var configuration  = isSelected ? UIButton.Configuration.filled() : UIButton.Configuration.bordered()
        configuration.title = "JP"
        return configuration
    }
}
