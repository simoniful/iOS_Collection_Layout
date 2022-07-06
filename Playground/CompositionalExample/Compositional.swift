//
//  Compositional.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import UIKit
import SnapKit

final class Compositional: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.getLayout())
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.register(CompositionalCell.self, forCellWithReuseIdentifier: CompositionalCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var dataSource: [MySection] = [
        .main(
            [
                .init(text: "(main 섹션) 아이템 1"),
                .init(text: "(main 섹션) 아이템 2"),
                .init(text: "(main 섹션) 아이템 3"),
                .init(text: "(main 섹션) 아이템 4"),
                .init(text: "(main 섹션) 아이템 5"),
                .init(text: "(main 섹션) 아이템 6"),
            ]
        ),
        .sub(
            [
                .init(text: "(sub 섹션) 아이템 1"),
                .init(text: "(sub 섹션) 아이템 2"),
                .init(text: "(sub 섹션) 아이템 3"),
                .init(text: "(sub 섹션) 아이템 4"),
                .init(text: "(sub 섹션) 아이템 5"),
                .init(text: "(sub 섹션) 아이템 6"),
                .init(text: "(sub 섹션) 아이템 7"),
                .init(text: "(sub 섹션) 아이템 8"),
                .init(text: "(sub 섹션) 아이템 9"),
                .init(text: "(sub 섹션) 아이템 10"),
                .init(text: "(sub 섹션) 아이템 11"),
                .init(text: "(sub 섹션) 아이템 12")
            ]
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env -> NSCollectionLayoutSection? in
            switch self.dataSource[sectionIndex] {
            case .main:
                return self.getListSection()
            case .sub:
                return self.getGridSection()
            }
        }
    }
    
    private func getListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
    }
    
    private func getGridSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        // collectionView의 width에 3개의 아이템이 위치하도록 하는 것
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, env) in
            guard let self = self else { return }
            let normalizedOffsetX = offset.x + 10
            let centerPoint = CGPoint(
                x: normalizedOffsetX + self.collectionView.bounds.width / 2,
                y: 20
            )
            visibleItems.forEach({ item in
                guard let cell = self.collectionView.cellForItem(at: item.indexPath) else { return }
                UIView.animate(withDuration: 0.3) {
                    cell.transform = item.frame.contains(centerPoint) ? .identity : CGAffineTransform(scaleX: 0.9, y: 0.9)
                }
            })
        }
        return section
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
}

extension Compositional: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.dataSource[section] {
        case let .main(items):
            return items.count
        case let .sub(items):
            return items.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompositionalCell.identifier, for: indexPath) as! CompositionalCell
        switch self.dataSource[indexPath.section] {
        case let .main(items):
            cell.prepare(text: items[indexPath.item].text)
        case let .sub(items):
            cell.prepare(text: items[indexPath.item].text)
        }
        return cell
    }
}
