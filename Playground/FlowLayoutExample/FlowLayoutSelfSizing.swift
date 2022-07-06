//
//  FlowLayoutSelfSizing.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import UIKit
import SnapKit

final class FlowLayoutSelfSizing: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = HorizontalFlowLayout()
        layout.delegate = self
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(FlowLayoutSelfSizingCell.self, forCellWithReuseIdentifier: FlowLayoutSelfSizingCell.identifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let dataSource: [String] = ["아이템", "아이템111", "아이템”222", "아이템3333", "아이템1111", "아이템3123123", "아이템123123", "아이템", "아이템12313", "아이템222", "아이템31231", "아이템23333", "아이템", "아이템232332", "아이템123123", "아이템66", "아이템2", "아이템", "아이템123123", "아이템3", "아이템123312", "아이템123123213", "아이템", "아이템", "아이템321312", "아이템3", "아이", "아이템2", "아이템", "아이템", "아이템4444", "아이템", "아이템", "아이템123123"]
    
    let sectionCount: CGFloat = 5
    let sectionHight: CGFloat = 37
    var sectionWidth: CGFloat = 0
    
    let itemHeight: CGFloat = 27
    
    let itemPadding: CGFloat = 8
    let padding: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.sectionWidth = self.view.bounds.width
        self._makeSectionWidth()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(sectionHight * sectionCount - padding * 2)
        }
    }
}

private extension FlowLayoutSelfSizing {
    private func _makeSectionWidth() {
        var sumSize: CGFloat = padding
        dataSource.forEach {
            sumSize += (self._makeTitleWidth(title: $0) + padding)
        }
        
        let oneLineWidth = sumSize / sectionCount
        var lastIndex: Int = 0
        var lineWitdh: CGFloat = padding
        var lineWitdhs: [CGFloat] = []
        
        dataSource.enumerated().forEach { index, item in
            let itemWidth: CGFloat = _makeTitleWidth(title: item)
            
            lineWitdh += itemWidth
            if lineWitdh > oneLineWidth {
                let widthDiff = lineWitdh - oneLineWidth
                if widthDiff < itemWidth/3 {
                    lineWitdh -= itemWidth
                    lineWitdhs.append(lineWitdh)
                    lineWitdh = itemWidth + padding
                    lastIndex = index
                } else {
                    lineWitdhs.append(lineWitdh)
                    lineWitdh = 0
                    lastIndex = index + 1
                }
            } else {
                lineWitdh += padding
            }
        }
        
        lineWitdh = padding
        for i in lastIndex..<dataSource.count {
            let itemWidth: CGFloat = _makeTitleWidth(title: dataSource[i])
            lineWitdh += itemWidth + padding
        }
        lineWitdhs.append(lineWitdh)
        
        guard let maxLineWitdh = lineWitdhs.max() else { return }
        self.sectionWidth = maxLineWitdh
    }
    
    private func _makeTitleWidth(title: String) -> CGFloat {
        return title.size(
            withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)
            ]
        ).width + itemPadding * 2
    }
}

extension FlowLayoutSelfSizing: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dataSource.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FlowLayoutSelfSizingCell.identifier,
            for: indexPath
        ) as? FlowLayoutSelfSizingCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(tag: dataSource[indexPath.item])
        return cell
    }
}

extension FlowLayoutSelfSizing: HorizontalFlowLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        sizeForPillAtIndexPath indexPath: IndexPath
    ) -> CGSize {
        let item = dataSource[indexPath.item]
        return CGSize(width: _makeTitleWidth(title: item), height: itemHeight)
    }
        
    func collectionView(
        _ collectionView: UICollectionView,
        insetsForItemsInSection section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: itemPadding, bottom: 3, right: itemPadding)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        itemSpacingInSection section: Int
    ) -> CGFloat {
        return padding
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        lineWidthSection: Int
    ) -> CGFloat {
        return sectionWidth
    }
}











