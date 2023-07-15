//
//  AnimeDetailPageViewController.swift
//  Anifu
//
//  Created by Indocyber on 20/05/23.
//

import Foundation
import UIKit
import RxSwift

protocol AnimeDetailPageBusinessLogic {
    func initialLoad(dependency: AnimeDetailDependency)
    func engButtonTapped()
    func jpnButtonTapped()
    func othButtonTapped()
    
    var animeDetailData: PublishSubject<AnimeDetailDependency> { get }
    var displayedTitle: PublishSubject<DisplayedTitle> { get }
    var animeTitle: PublishSubject<AnimeTitle> { get }
}

class AnimeDetailPageViewController: UIViewController {
    
    // MARK: UI Component
    
    let backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let gradient = CAGradientLayer()

        scrollView.backgroundColor = .black
        scrollView.alpha = 0.9
        return scrollView
    }()
    
    let containerContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let animeInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let airedDateLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
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
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let typeLabelValue: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let animeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let animeImageContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    let headerAndNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let animeNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let nameButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return stackView
    }()
    
    let engNameButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.configEngNameButton(isSelected: true)
        return button
    }()
    
    let jpnNameButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.configJpnNameButton(isSelected: false)
        return button
    }()
    
    let nameAndButtonNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        stackView.layer.cornerRadius = 8
        stackView.spacing = 8
        stackView.setMargin(.init(marginAll: 8))
        return stackView
    }()
    
    let headerStackViewContainerView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: Required Data
    
    var animeName: String = "" {
        didSet {
            animeNameLabel.text = animeName
        }
    }
    
    var animeImage: UIImage = UIImage() {
        didSet {
            backgroundView.image = animeImage
            animeImageView.image = animeImage
            animeImageContainer.heightAnchor.constraint(equalTo: animeImageView.widthAnchor, multiplier: animeImageView.image!.size.height / animeImageView.image!.size.width).isActive = true

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
    
    var animeTitles: AnimeTitle?
    
    // MARK: Required Init
    let viewModel: AnimeDetailPageBusinessLogic
    let disposeBag = DisposeBag()
    
    // MARK: Setup UILayout
    
    init(viewModel: AnimeDetailPageBusinessLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleButton() {
        engNameButton.addTarget(self, action: #selector(engButtonTapped), for: .touchUpInside)
        jpnNameButton.addTarget(self, action: #selector(jpnButtonTapped), for: .touchUpInside)
    }
    
    private func initialBind() {
        viewModel.animeDetailData
            .subscribe(on: MainScheduler.instance)
            .subscribe(
            onNext: { [weak self] data in
                self?.animeImage = data.animeImage
                self?.animeAiredDate = AnifuDateFormatter.shared.formatDate(format: .MMyyyy).string(from: data.animeAired)
                self?.animeName = data.animeTitle
                self?.animeType = data.animeType
                self?.animeRating = data.animeRating
                self?.animeRanking = data.animeRanking
            }
        )
        .disposed(by: disposeBag)
    }
    
    private func bindAnimeTitles() {
        viewModel.animeTitle
            .subscribe(
                onNext: { [weak self] title in
                    self?.animeTitles = title
                }
            )
            .disposed(by: disposeBag)
    }
    
    
    private func bindTitleButton() {
        viewModel.displayedTitle
            .subscribe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] displayedTitle in
                    switch displayedTitle {
                    case .Eng:
                        self?.animeName = self?.animeTitles?.english ?? "XXX"
                        self?.engNameButton.configuration = UIButton.Configuration.configEngNameButton(isSelected: true)
                        self?.jpnNameButton.configuration = UIButton.Configuration.configJpnNameButton(isSelected: false)
                    case .Jpn:
                        self?.animeName = self?.animeTitles?.japanese ?? "XXX"
                        self?.jpnNameButton.configuration = UIButton.Configuration.configJpnNameButton(isSelected: true)
                        self?.engNameButton.configuration = UIButton.Configuration.configEngNameButton(isSelected: false)
                    case .Oth:
                        break
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(contentScrollView)
        
        backgroundView.pinToAllSideWithSafeArea(to: view)
        contentScrollView.pinToAllSideWithSafeArea(to: view)
        
        contentScrollView.addSubview(containerContentView)
        containerContentView.pinToAllSides(to: contentScrollView)
        
        containerContentView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerHeightAnchor = containerContentView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor, multiplier: 1)
        containerHeightAnchor.isActive = true
        containerHeightAnchor.priority = UILayoutPriority(250)
        containerContentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor, multiplier: 1).isActive = true
        containerContentView.addSubview(contentView)
      
        contentView.pinToAllSideWith16Constant(to: containerContentView)
        contentView.addSubview(headerAndNameStackView)
        
        headerAndNameStackView.addArrangedSubview(headerStackViewContainerView)
        headerStackViewContainerView.addSubview(headerStackView)
        headerStackView.pinToAllSides(to: headerStackViewContainerView)
        headerAndNameStackView.addArrangedSubview(nameAndButtonNameStackView)
        nameAndButtonNameStackView.addArrangedSubview(animeNameLabel)
        nameAndButtonNameStackView.addArrangedSubview(nameButtonStackView)
        nameButtonStackView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        nameButtonStackView.addArrangedSubview(engNameButton)
        nameButtonStackView.addArrangedSubview(jpnNameButton)
        
        headerAndNameStackView.translatesAutoresizingMaskIntoConstraints = false
        headerAndNameStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerAndNameStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headerAndNameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headerAndNameStackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 0).isActive = true
        headerStackView.addArrangedSubview(animeImageContainer)
        animeImageContainer.addSubview(animeImageView)
        animeImageView.pinToAllSides(to: animeImageContainer)
        animeImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        animeImageView.translatesAutoresizingMaskIntoConstraints = false
     
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
        view.backgroundColor = .black
        initialBind()
        setupTitleButton()
        bindTitleButton()
        bindAnimeTitles()
    }
    
}

extension AnimeDetailPageViewController: DataReceiver {
    typealias D = AnimeDetailDependency
    
    func receiveData<D>(data: D) throws {
        guard let data = data as? AnimeDetailDependency else {
            throw DataError.DataNotMatch
        }
        viewModel.initialLoad(dependency: data)
    }
}

extension AnimeDetailPageViewController {
    @objc func engButtonTapped() {
        viewModel.engButtonTapped()
    }
    
    @objc func jpnButtonTapped() {
        viewModel.jpnButtonTapped()
    }
    
    @objc func othButtonTapped() {
        viewModel.othButtonTapped()
    }
}
