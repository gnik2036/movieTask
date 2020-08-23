//
//  UpcomingMoviesEmptyView.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

final class UpcomingMoviesEmptyView: UIView {
    // MARK: - Static -
    static let size = CGSize(width: 250, height: 400)
    
    // MARK: - Views -
    private let imgView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "movie_error").withRenderingMode(.alwaysTemplate))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "No movies found"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
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
extension UpcomingMoviesEmptyView {
    func update(searchText: String) {
        titleLabel.text = "No movies found for \"\(searchText)\""
    }
}

// MARK: - CodeView -
extension UpcomingMoviesEmptyView: CodeView {
    func buildViewHierarchy() {
        addSubview(imgView)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        imgView.anchor(top: topAnchor,
                       leading: leadingAnchor,
                       trailing: trailingAnchor,
                       insets: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        titleLabel.anchor(top: imgView.bottomAnchor,
                          leading: leadingAnchor,
                          trailing: trailingAnchor,
                          insets: .init(top: 8, left: 8, bottom: 0, right: 8))
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
