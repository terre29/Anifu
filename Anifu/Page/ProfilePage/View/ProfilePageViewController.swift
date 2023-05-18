//
//  ProfilePageViewController.swift
//  Anifu
//
//  Created by Indocyber on 11/05/23.
//

import Foundation
import UIKit

class ProfilePageViewController: UIViewController {
    private var menuTable: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private var dataSource: UITableViewDiffableDataSource<ProfileSection, ProfilePageWrapper>!
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<ProfileSection, ProfilePageWrapper>(tableView: menuTable, cellProvider: { tableView, indexPath, item in
            switch item {
            case .profileBody(let body):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellBody", for: indexPath) as? ProfilePageCell else { return UITableViewCell() }
                cell.cellIcon.image = body.icon
                cell.cellName.text = body.settingName
                return cell
                
            case .profileHeader(let header):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProfilePageHeaderCell else { return UITableViewCell() }
                cell.descriptionLabel.text = header.description
                cell.nameLabel.text = header.name
                cell.profileImage.image = header.profileImage
                return cell
            }
           
        })
    }
    
    private func setupTableView() {
        menuTable = UITableView(frame: view.bounds, style: .plain)
        menuTable.register(ProfilePageCell.self, forCellReuseIdentifier: "cellBody")
        menuTable.register(ProfilePageHeaderCell.self, forCellReuseIdentifier: "cell")
        menuTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        menuTable.delegate = self
    }
    
    private func setupInitialData() {
        var snapShot = NSDiffableDataSourceSnapshot<ProfileSection, ProfilePageWrapper>()
        snapShot.appendSections(ProfileSection.allCases)
        
        snapShot.appendItems([
            .profileBody(.init(icon: UIImage(named: "profile.anime.icon") ?? UIImage(), settingName: "Anime Preference", profileId: .AnimePreference)),
            .profileBody(.init(icon: UIImage(systemName: "questionmark.circle") ?? UIImage(), settingName: "About", profileId: .Profile)),
            
        ], toSection: .normal)
        
        snapShot.appendItems([
            .profileHeader(.init(name: "You", description: "This is you, although not always like you", profileImage: UIImage(named: "anime.you.pp") ?? UIImage()))
        ], toSection: .header)
        
        dataSource.apply(snapShot)
        
    }
    
    private func setupLayout() {
        view.addSubview(menuTable)
        menuTable.pinToAllSideWithSafeArea(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupTableView()
        setupDataSource()
        setupLayout()
        setupInitialData()
    }
}

extension ProfilePageViewController {
    enum ProfileSection: Int, CaseIterable {
        case header
        case normal
    }
    
    enum ProfilePageWrapper: Hashable {
        case profileHeader(ProfilePageHeaderCellViewModel)
        case profileBody(ProiflePageCellViewModel)
    }
}

extension ProfilePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        switch item {
        case .profileBody(let profile):
            print("\(profile.profileId)")
        case .profileHeader(let profile):
            break
        }
    }
}
