//
//  FlowLayoutSelfSizingCell.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import UIKit
import SnapKit

final class FlowLayoutSelfSizingCell: UICollectionViewCell {
    static let identifier = "FlowLayoutSelfSizingCell"
    
    private lazy var tagButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemOrange.cgColor
        contentView.layer.cornerRadius = 12.0
        contentView.clipsToBounds = true
    }
    
    func setup(tag: String) {
        setupLayout()
        tagButton.setTitle(tag, for: .normal)
        layoutIfNeeded()
    }
}

private extension FlowLayoutSelfSizingCell {
    func setupLayout() {
        contentView.addSubview(tagButton)
        
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
