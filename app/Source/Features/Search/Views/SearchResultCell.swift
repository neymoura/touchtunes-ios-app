//
//  SearchResultCell.swift
//  App
//
//  Created by Ney Moura on 13/06/21.
//

import UIKit

protocol SearchResultCellDelegate: AnyObject {
    func didSelect(_ result: SearchResultUI)
}

class SearchResultCell: UITableViewCell {
    
    // MARK: - Vars
    weak var delegate: SearchResultCellDelegate?
    
    var searchResult: SearchResultUI? {
        didSet { setupValues() }
    }
    
    // MARK: - Layout vars
    
    // TODO: Missing style guide
    private lazy var nameLabel: UILabel = {
        let label = UILabel().useConstraint()
        return label
    }()
    
    // TODO: Missing style guide
    private lazy var releaseLabel: UILabel = {
        let label = UILabel().useConstraint()
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, releaseLabel]).useConstraint()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var artworkView: UIImageView = {
        let view = UIImageView().useConstraint()
        view.layer.cornerRadius = SGValues.Other.defaultRadius
        view.clipsToBounds = true
        view.backgroundColor = SGColors.grey
        return view
    }()
    
    // MARK: - Inits
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupActions()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupActions()
    }

    // MARK: - Setups
    private func setupLayout() {
        selectionStyle = .none
        backgroundColor = SGColors.clear
        
        contentView.addSubview(artworkView)
        contentView.addSubview(infoStack)
        
        artworkView
            .height(constant: SGSearch.searchCellImageSize)
            .width(constant: SGSearch.searchCellImageSize)
            .top(anchor: contentView.topAnchor, constant: SGValues.Vertical.single)
            .leading(anchor: contentView.leadingAnchor, constant: SGValues.Horizontal.single)
            .bottom(anchor: contentView.bottomAnchor, constant: -SGValues.Vertical.single)
        
        infoStack
            .top(anchor: contentView.topAnchor, constant: SGValues.Vertical.single)
            .leading(anchor: artworkView.trailingAnchor, constant: SGValues.Horizontal.single)
            .trailing(anchor: contentView.trailingAnchor, constant: -SGValues.Horizontal.single)
            .bottom(anchor: contentView.bottomAnchor, constant: -SGValues.Vertical.single)
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap) )
        contentView.addGestureRecognizer(tapGesture)
    }
    
    private func setupValues() {
        guard let searchResult = searchResult else { return }
        nameLabel.text = searchResult.name
        releaseLabel.text = searchResult.releaseDate
        artworkView.load(imageUrl: searchResult.artwork)
    }
}

// MARK: - Actions
extension SearchResultCell {
    @objc private func didTap() {
        guard let searchResult = searchResult else { return }
        delegate?.didSelect(searchResult)
    }
}
