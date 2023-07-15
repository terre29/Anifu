 //
//  AnimeCollectionViewCell.swift
//  Anifu
//
//  Created by Terretino on 15/12/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SkeletonView

class AnimeCollectionViewCell: UICollectionViewCell {
    
    private let disposeBag = DisposeBag()

    var model: AnimeCardModel = AnimeCardModel(animeName: "", animeImageURL: "", malId: 0, isLoading: true, animeData: AnimeData(rating: "", score: 0, type: "", status: "", background: "", synopsys: "", rank: 0, aired: Date(), titleJp: "", titleEng: "")) {
        didSet {
            populateData()
        }
    }
    
    var isLoading: Bool = true {
        didSet {
            if isLoading {
                showAnimatedSkeleton()
            } else {
                hideSkeleton()
            }
        }
    }
    
    var animeImageCapturedData = BehaviorRelay(value: UIImage())
    let animeImageCache = NSCache<NSNumber, UIImage>()

    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.isSkeletonable = true
        return label
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.isSkeletonable = true
        return view
    }()
    
    lazy var animeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        return imageView
    }()
    
    lazy var imageAndTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.addArrangedSubview(animeImage)
        stackView.addArrangedSubview(titleView)
        stackView.isSkeletonable = true
        return stackView
    }()
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        skeletonCornerRadius = 8
        return view
    }()
    
    convenience init(model: AnimeCardModel) {
        self.init(frame: .zero)
        self.model = model
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        contentView.isSkeletonable = true
        isSkeletonable = true
        skeletonCornerRadius = 8
        animeImageCache.countLimit = 100
        isLoading = true
    }
    
    override func prepareForReuse() {
        self.title.text = ""
        self.animeImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImage() {
        guard let imageURL = URL(string: model.animeImageURL) else { return }
            URLRequest.loadImage(resource: ImageResource(url: imageURL))
                .subscribe(onNext: { [weak self] data in
                    if let image = UIImage(data: data) {
                        self?.animeImageCapturedData.accept(image)
                        self?.animeImageCache.setObject(image, forKey: NSNumber(integerLiteral: (self?.model.malId)!))
                    } else {
                        // apply default value
                    }
                })
                .disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        contentView.addSubview(baseView)
        baseView.addSubview(imageAndTitleStackView)
        titleView.addSubview(title)
        baseView.pinToAllSides(to: contentView)
        imageAndTitleStackView.pinToAllSides(to: baseView)
        title.pinToAllSideWith8Constant(to: titleView)
        titleView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        titleView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func populateData() {
        DispatchQueue.main.async {
            self.model.title.asDriver(onErrorJustReturn: "Error")
                .drive(self.title.rx.text)
                .disposed(by: self.disposeBag)
            self.animeImageCapturedData.asDriver(onErrorJustReturn: UIImage())
                .drive(self.animeImage.rx.image)
                .disposed(by: self.disposeBag)
        }
        isLoading = model.isLoading
    }
    
    func didSelectCell() -> UIImage {
        return animeImage.image ?? UIImage()
    }
    
}

