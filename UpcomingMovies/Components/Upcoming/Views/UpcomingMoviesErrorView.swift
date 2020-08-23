//
//  UpcomingMoviesErrorView.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

protocol UpcomingMoviesErrorViewDelegate: AnyObject {
    func upcomingMoviesErrorViewDidTapButton()
}

final class UpcomingMoviesErrorView: UIView {
    // MARK: - Static -
    static let size = CGSize(width: 250, height: 100)
    
    // MARK: - Properties -
    weak var delegate: UpcomingMoviesErrorViewDelegate?
    
    // MARK: - Views -
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "An unexpected error occurred :("
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Try again", for: .normal)
        btn.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.layer.cornerRadius = 10.0
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.black.cgColor
        return btn
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
extension UpcomingMoviesErrorView {
    func setError(text: String?) {
        titleLabel.text = text
    }
}

// MARK: - Actions -
extension UpcomingMoviesErrorView {
    @objc private func didTapBtn() {
        delegate?.upcomingMoviesErrorViewDidTapButton()
    }
}

// MARK: - CodeView -
extension UpcomingMoviesErrorView: CodeView {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(button)
    }
    
    func setupConstraints() {
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          trailing: trailingAnchor,
                          insets: .init(top: 8, left: 8, bottom: 0, right: 8))
        
        button.anchor(top: titleLabel.bottomAnchor,
                      leading: leadingAnchor,
                      trailing: trailingAnchor,
                      insets: .init(top: 8, left: 8, bottom: 0, right: 8))
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
