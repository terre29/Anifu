//
//  AnimeDetailPageComposer.swift
//  Anifu
//
//  Created by Indocyber on 27/05/23.
//

import Foundation

class AnimeDetailPageComposer {
    static func createAnimeDetailViewController(viewModel: AnimeDetailViewModel) -> AnimeDetailPageViewController {
        let viewController = AnimeDetailPageViewController(viewModel: viewModel)
        return viewController
    }
    
}
