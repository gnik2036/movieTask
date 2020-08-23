//
//  MovieDetailViewControllerScreen.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

final class MovieDetailViewControllerScreen: UIView {

    // MARK: - Views -
    private let scrollView = UIScrollView(frame: .zero)
    private let containerView = UIView()

    private let imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()

    // MARK: - Init -
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public functions -
extension MovieDetailViewControllerScreen {
    func setup(movie: Movie) {
        if let backdropUrlString = movie.backdropUrlString, !backdropUrlString.isEmpty {
            imgView.download(urlString: backdropUrlString)
        } else {
            imgView.image = UIImage(named: "movie_error")
        }

        if let releaseYear = movie.releaseYear, !releaseYear.isEmpty {
            releaseYearLabel.text = releaseYear
        } else {
            releaseYearLabel.text = ""
        }

        if let voteAverage = movie.voteAverage {
            voteAverageLabel.text = "\(voteAverage)/10"
        } else {
            voteAverageLabel.text = ""
        }

        if let genreIds = movie.genreIds {
            let genres = genreIds.compactMap { (id) -> String? in
                return Genre.getNameBy(id: id)
            }
            if genres.isEmpty {
                genresLabel.text = "No genre found"
            } else {
                genresLabel.text = genres.joined(separator: ", ")
            }
        } else {
            genresLabel.text = "No genre found"
        }

        if let overView = movie.overview, !overView.isEmpty {
            overViewLabel.text = overView
        } else {
            overViewLabel.text = ""
        }
    }
}

// MARK: - CodeView -
extension MovieDetailViewControllerScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)

        containerView.addSubview(imgView)
        containerView.addSubview(releaseYearLabel)
        containerView.addSubview(voteAverageLabel)
        containerView.addSubview(genresLabel)
        containerView.addSubview(overViewLabel)
    }

    func setupConstraints() {
        scrollView.fillSuperview()

        containerView.anchor(top: scrollView.topAnchor,
                             leading: scrollView.leadingAnchor,
                             bottom: scrollView.bottomAnchor,
                             trailing: scrollView.trailingAnchor,
                             insets: .init(top: 0, left: 0, bottom: 0, right: 0))
        containerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

        imgView.anchor(top: containerView.topAnchor,
                       leading: containerView.leadingAnchor,
                       trailing: containerView.trailingAnchor,
                       insets: .zero)
        imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor, multiplier: 0.5).isActive = true

        releaseYearLabel.anchor(top: imgView.bottomAnchor,
                                leading: containerView.leadingAnchor,
                                insets: .init(top: 8, left: 8, bottom: 0, right: 0))

        voteAverageLabel.anchor(top: imgView.bottomAnchor,
                                trailing: containerView.trailingAnchor,
                                insets: .init(top: 8, left: 0, bottom: 0, right: 8))

        genresLabel.anchor(top: releaseYearLabel.bottomAnchor,
                           leading: containerView.leadingAnchor,
                           trailing: containerView.trailingAnchor,
                           insets: .init(top: 8, left: 8, bottom: 0, right: 8))

        overViewLabel.anchor(top: genresLabel.bottomAnchor,
                             leading: containerView.leadingAnchor,
                             bottom: containerView.bottomAnchor,
                             trailing: containerView.trailingAnchor,
                             insets: .init(top: 8, left: 8, bottom: 8, right: 8))
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
