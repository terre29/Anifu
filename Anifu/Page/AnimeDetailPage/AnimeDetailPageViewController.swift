//
//  AnimeDetailPageViewController.swift
//  Anifu
//
//  Created by Indocyber on 20/05/23.
//

import Foundation
import UIKit

protocol AnimeDetailPageBusinessLogic {
    func initialLoad() -> AnimeDetailDependency
}

class AnimeDetailPageViewController: UIViewController {
    
    // MARK: UI Component
    
    let backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .green
        return scrollView
    }()
    
    let containerContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let animeInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let rankingAndRatingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let rankingLabel: UILabel = {
        let label = UILabel()
        label.text = "#1"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "4.8"
        return label
    }()
    
    let typeAndAiredStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
   
        return stackView
    }()
    
    let airedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let airedLabel: UILabel = {
        let label = UILabel()
        label.text = "Aired"
        return label
    }()
    
    let airedDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let typeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        return label
    }()
    
    let typeLabelValue: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let animeImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: Required Data
    
    var animeImage: UIImage = UIImage() {
        didSet {
            animeImageView.image = animeImage
        }
    }
    
    var animeAiredDate: String = "" {
        didSet {
            airedDateLabel.text = animeAiredDate
        }
    }
    
    var animeType: String = "" {
        didSet {
            typeLabelValue.text = animeType
        }
    }
    
    var animeRanking: String = "" {
        didSet {
            rankingLabel.text = animeRanking
        }
    }
    
    var animeRating: String = "" {
        didSet {
            ratingLabel.text = animeRating
        }
    }
    
    // MARK: Required Init
    let viewModel: AnimeDetailViewModel
    
    // MARK: Setup UILayout
    
    init(viewModel: AnimeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(contentScrollView)
        
        backgroundView.pinToAllSides(to: view)
        contentScrollView.pinToAllSideWithSafeArea(to: view)
        
        contentScrollView.addSubview(containerContentView)
        containerContentView.pinToAllSides(to: contentScrollView)
        
        containerContentView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerHeightAnchor = containerContentView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor, multiplier: 1)
        containerHeightAnchor.isActive = true
        containerHeightAnchor.priority = UILayoutPriority(250)
        containerContentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 1).isActive = true
        containerContentView.addSubview(contentView)
      
        contentView.pinToAllSides(to: containerContentView)
        contentView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        contentView.addSubview(headerStackView)
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headerStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        headerStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 0).isActive = true
        headerStackView.addArrangedSubview(animeImageView)
        headerStackView.addArrangedSubview(animeInformationStackView)
        
        animeInformationStackView.addArrangedSubview(rankingAndRatingsStackView)
        rankingAndRatingsStackView.addArrangedSubview(rankingLabel)
        rankingAndRatingsStackView.addArrangedSubview(ratingLabel)
        
        animeInformationStackView.addArrangedSubview(typeAndAiredStackView)
        typeAndAiredStackView.addArrangedSubview(typeStackView)
        typeStackView.addArrangedSubview(typeLabel)
        typeStackView.addArrangedSubview(typeLabelValue)
        
        typeAndAiredStackView.addArrangedSubview(airedStackView)
        airedStackView.addArrangedSubview(airedLabel)
        airedStackView.addArrangedSubview(airedDateLabel)
    }
    
    override func viewDidLoad() {
        let requiredData = viewModel.initialLoad()
        animeImage = requiredData.animeImage
        animeType = requiredData.animeType
        animeRating = requiredData.animeRating
        animeRanking = requiredData.animeRanking
    }
    
}

extension AnimeDetailPageViewController: DataReceiver {
    typealias D = AnimeDetailDependency
    
    func receiveData<D>(data: D) throws {
        guard let data = data as? AnimeDetailDependency else {
            throw DataError.DataNotMatch
        }
        viewModel.animeDetailDependency = data 
    }
}
