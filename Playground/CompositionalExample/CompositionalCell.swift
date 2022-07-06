//
//  CompositionalCell.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import UIKit
import SnapKit

final class CompositionalCell: UICollectionViewCell {
    static let identifier = "CompositionalCell"
    
    // MARK: UI
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.systemOrange
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: "")
    }
    
    func prepare(text: String) {
        self.label.text = text
    }
}
