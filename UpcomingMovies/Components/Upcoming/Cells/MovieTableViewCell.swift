//
//  MovieTableViewCell.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

final class MovieTableViewCell: UITableViewCell {

    // MARK: - Static -
    static let height: CGFloat = 170

    // MARK: - Views -
    private let imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions -
    func setup(movie: Movie) {
        if let posterUrlString = movie.posterUrlString, !posterUrlString.isEmpty {
            imgView.download(urlString: posterUrlString)
        } else {
            imgView.image = UIImage(named: "movie_error")
        }
        
        if let title = movie.title, !title.isEmpty {
            titleLabel.text = title
        } else {
            titleLabel.text = "Title not found"
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

// MARK: - Init -
extension MovieTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseYearLabel)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(overViewLabel)
    }
    
    func setupConstraints() {
        imgView.anchor(top: contentView.topAnchor,
                       leading: contentView.leadingAnchor,
                       bottom: contentView.bottomAnchor,
                       insets: .zero)
        imgView.anchor(width: 120)

        titleLabel.anchor(top: contentView.topAnchor,
                          leading: imgView.trailingAnchor,
                          trailing: contentView.trailingAnchor,
                          insets: .init(top: 8, left: 8, bottom: 0, right: 8))

        releaseYearLabel.anchor(top: titleLabel.bottomAnchor,
                                leading: imgView.trailingAnchor,
                                insets: .init(top: 0, left: 8, bottom: 0, right: 0))

        voteAverageLabel.anchor(top: titleLabel.bottomAnchor,
                                trailing: contentView.trailingAnchor,
                                insets: .init(top: 0, left: 0, bottom: 0, right: 8))

        genresLabel.anchor(top: releaseYearLabel.bottomAnchor,
                           leading: imgView.trailingAnchor,
                           trailing: contentView.trailingAnchor,
                           insets: .init(top: 0, left: 8, bottom: 0, right: 8))

        overViewLabel.anchor(top: genresLabel.bottomAnchor,
                             leading: imgView.trailingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             insets: .init(top: 0, left: 8, bottom: 8, right: 8))
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        contentView.backgroundColor = .white
    }
}
