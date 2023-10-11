//
//  TopAnimeViewController.swift
//  Anifu
//
//  Created by Terretino on 03/01/23.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift

class AnimeListViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    var labelTest: UILabel = {
        let label = UILabel()
        label.text = "JAGO NJIR"
        return label
        
    }()
    
    private lazy var dataSource = makeTableViewDataSource()
    private var animeListViewModel: AnimeListViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        view.addSubview(labelTest)
        labelTest.pinToAllSides(to: view)
        //loadAnime()
    }
    
    private func populateAnimeList() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Anime>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(self.animeListViewModel.animeList)
        dataSource.apply(snapshot)
    }
    
    private func loadAnime() {
        let url = URL(string: "https://api.jikan.moe/v4/top/anime")!
            .appending("limit", value: "10")
            .appending("page", value: "0")
        let resource = Resource<JikanResponse>(url: url)
        URLRequest.load(resource: resource)
            .subscribe(onNext: { response in
                let anime = response.data
                self.animeListViewModel = AnimeListViewModel(anime: anime)
                DispatchQueue.main.async { [weak self] in
                    self?.populateAnimeList()
                }
            })
            .disposed(by: disposeBag)
    }
}

struct AnimeListViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = AnimeListViewController()
            return vc
        }
    }
}

extension AnimeListViewController {
    
    enum Section: Int, CaseIterable {
        case Top
    }
    
    func makeTableViewDataSource() -> UITableViewDiffableDataSource<Section, Anime> {
        let reuseIdentifier = "cell"

                return UITableViewDiffableDataSource(
                    tableView: tableView,
                    cellProvider: {  tableView, indexPath, anime in
                        let cell = tableView.dequeueReusableCell(
                            withIdentifier: reuseIdentifier,
                            for: indexPath
                        )
                        return cell
                    }
                )
    }
    
    func makeTableRegistration() {
        
    }
}
