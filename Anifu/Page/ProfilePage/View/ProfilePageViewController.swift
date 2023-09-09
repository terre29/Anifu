//
//  ProfilePageViewController.swift
//  Anifu
//
//  Created by Indocyber on 11/05/23.
//

import Foundation
import UIKit
import RxSwift

class ProfilePageViewController: UIViewController {
    
    // MARK: Property
    let viewModel: ProfilePageViewModel
    let disposeBag = DisposeBag()
    var currentSnapshot: NSDiffableDataSourceSnapshot<ProfileSection, ProfilePageWrapper>?
    
    // MARK: Init
    init(viewModel: ProfilePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Component
    private var menuTable: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: Data Source
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
                cell.nameTapped = { [weak self] in
                    self?.setAlert()
                }
                return cell
            }
           
        })
    }
    
    // MARK: Setup Function
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
        currentSnapshot = snapShot
    }
    
    private func setupLayout() {
        view.addSubview(menuTable)
        menuTable.pinToAllSideWithSafeArea(to: view)
    }
    
    private func setupDataFromCoreData() {
        let data = viewModel.fetchUserData()
        viewModel.updateName(name: data.userName ?? "")
    }
    
    private func setAlert() {
        let alert = UIAlertController(title: "Change name", message: "Please input your preferred user name", preferredStyle: .alert)
        alert.addTextField()
        
        let submitButton = UIAlertAction(title: "Change", style: .default) { [weak self] action in
            guard let self else { return }
            let nameTextField = alert.textFields![0]
            let newName = nameTextField.text
            viewModel.updateNameCoreData(newName ?? "")
            viewModel.updateName(name: newName ?? "")
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        alert.addAction(submitButton)
        present(alert, animated: true)
    }
    
    // MARK: Binding
    private func bindName() {
        viewModel.userName
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] name in
                guard let self else { return }
                self.updateHeaderSnapshot(headerData: .init(userName: name, userImage: UIImage()))
            })
            .disposed(by: disposeBag)
    }
    
    private func updateHeaderSnapshot(headerData: ProfileHeaderViewModel) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            
            self.currentSnapshot?.deleteSections([ProfileSection.header])
            self.currentSnapshot?.insertSections([ProfileSection.header], beforeSection: .normal)
            self.currentSnapshot?.appendItems([
                .profileHeader(.init(name: headerData.userName, description: "This is you, although not always like you", profileImage: UIImage(named: "anime.you.pp") ?? UIImage()))
            ], toSection: .header)
            DispatchQueue.main.async {
                self.dataSource.apply(self.currentSnapshot!, animatingDifferences: false)
            }
        }
    }
    

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindName()
        setupDataSource()
        setupLayout()
        setupInitialData()
        setupDataFromCoreData()
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
