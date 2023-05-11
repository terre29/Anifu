//
//  BrowsePageViewModelTest.swift
//  AnifuTests
//
//  Created by Indocyber on 09/05/23.
//

import XCTest
@testable import Anifu

class BrowsePageViewModelPhantomDouble: BrowseAnimeViewControllerBusinessLogic {
    var getForYouAnimeCalled = 0
    var getTrendingAnimeCalled = 0
    var getUpcomingSeasonAnimeCalled = 0
    var getThisSeasonAnimeCalled = 0
    
    func getForYouAnime() {
        getForYouAnimeCalled += 1
    }
    
    func getTrendingAnime() {
        getTrendingAnimeCalled += 1
    }
    
    func getUpcomingSeason() {
        getUpcomingSeasonAnimeCalled += 1
    }
    
    func getThisSeason() {
        getThisSeasonAnimeCalled += 1
    }
    
    
}

class BrowsePageViewControllerTests: XCTestCase {
    
    func makeSut() -> BrowseAnimeViewController {
        let browseViewModel = BrowseViewModel()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        let sut = BrowseAnimeViewController(dependency: .init(
            dataSource: CollectionViewSkeletonDiffableDataSource(
                collectionView: collectionView,
                cellProvider: { cell, indexPath, model in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnimeCollectionViewCell
                    cell.model = model
                    return cell
                }),
            browseViewModel: browseViewModel,
            businessLogic: BrowsePageViewModelPhantomDouble())
        )
        return sut
    }
    
    func test_whenViewLoaded_should_call_getForYou() {
        // given
        var sut = makeSut()
        let spy = BrowsePageViewModelPhantomDouble()
        sut.dependency.businessLogic = spy
        
        // when
        loadView(withSut: sut)
        
        // then
        XCTAssert(spy.getForYouAnimeCalled == 1)
    }
    
    func test_whenViewLoaded_should_call_getThisSeasonAnime() {
        // given
        var sut = makeSut()
        let spy = BrowsePageViewModelPhantomDouble()
        sut.dependency.businessLogic = spy
        
        // when
        loadView(withSut: sut)
        
        // then
        XCTAssert(spy.getThisSeasonAnimeCalled == 1)
    }
    
    func test_whenViewLoaded_should_call_getUpcomingSeasonAnime() {
        // given
        var sut = makeSut()
        let spy = BrowsePageViewModelPhantomDouble()
        sut.dependency.businessLogic = spy
        
        // when
        loadView(withSut: sut)
        
        // then
        XCTAssert(spy.getUpcomingSeasonAnimeCalled == 1)
    }
    
    func test_whenViewLoaded_should_call_getTrendingAnime() {
        // given
        var sut = makeSut()
        let spy = BrowsePageViewModelPhantomDouble()
        sut.dependency.businessLogic = spy
        
        // when
        loadView(withSut: sut)
        
        // then
        XCTAssert(spy.getTrendingAnimeCalled == 1)
    }
    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }
    
}
