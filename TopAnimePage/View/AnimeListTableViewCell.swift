//
//  AnimeListTableViewCell.swift
//  Anifu
//
//  Created by Terretino on 03/01/23.
//

import Foundation
import UIKit
import RxSwift

class AnimeListTableViewCell: UITableViewCell {
    
    var animeImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var animeTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var yearLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var numberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    var scoreAndRatingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    var titleAndYearStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    var rightContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let model: Anime
    let disposeBag = DisposeBag()
    
    init(model: Anime) {
        self.model = model
        super.init(frame: .zero)
        setupStackView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(baseStackView)
        baseStackView.pinToAllSides(to: contentView)
    }
    
    private func populateData() {
        model.title.asDriver(onErrorJustReturn: "")
            .drive(animeTitle.rx.text)
            .disposed(by: disposeBag)
        
        model.score.asDriver(onErrorJustReturn: "")
            .drive(scoreLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.year.asDriver(onErrorJustReturn: "")
            .drive(yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.rating.asDriver(onErrorJustReturn: "")
            .drive(ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.status.asDriver(onErrorJustReturn: "")
            .drive(statusLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupStackView() {
        baseStackView.addArrangedSubview(numberLabel)
        baseStackView.addArrangedSubview(animeImage)
        baseStackView.addArrangedSubview(rightContentView)
        
        titleAndYearStackView.addArrangedSubview(animeTitle)
        titleAndYearStackView.addArrangedSubview(yearLabel)
        
        scoreAndRatingsStackView.addArrangedSubview(scoreLabel)
        scoreAndRatingsStackView.addArrangedSubview(ratingLabel)
        
        rightContentView.addArrangedSubview(titleAndYearStackView)
        rightContentView.addArrangedSubview(statusLabel)
        rightContentView.addArrangedSubview(scoreAndRatingsStackView)
    }
}
