//
//  AnimeDetailViewModel.swift
//  Anifu
//
//  Created by Indocyber on 27/05/23.
//

import Foundation
import UIKit
import RxSwift


class AnimeDetailViewModel: AnimeDetailPageBusinessLogic {
    
    var animeDetailData = PublishSubject<AnimeDetailDependency>()
    var displayedTitle = PublishSubject<DisplayedTitle>()
    var animeTitle = PublishSubject<AnimeTitle>()
    
    func initialLoad(dependency: AnimeDetailDependency) {
        animeTitle.onNext(dependency.titles)
        animeDetailData.onNext(dependency)
    }
    
    func engButtonTapped() {
        displayedTitle.onNext(.Eng)
    }
    
    func jpnButtonTapped() {
        displayedTitle.onNext(.Jpn)
    }
    
    func othButtonTapped() {
        displayedTitle.onNext(.Oth)
    }
}


