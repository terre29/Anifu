//
//  AnimeDetailViewModel.swift
//  Anifu
//
//  Created by Indocyber on 27/05/23.
//

import Foundation

class AnimeDetailViewModel: AnimeDetailPageBusinessLogic {
  
    var animeDetailDependency: AnimeDetailDependency
    
    init(animeDetailDependency: AnimeDetailDependency) {
        self.animeDetailDependency = animeDetailDependency
    }
    
    func initialLoad() -> AnimeDetailDependency {
        return animeDetailDependency
    }
    

}
