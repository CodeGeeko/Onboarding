//
//  UICollectionView+Geeko.swift
//  Onboarding
//
//  Created by Kuldeep Bhatt on 2021/09/02.
//

import Foundation

public extension UICollectionView {
    static let kDefaultIdentifier = "default"

    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register<T: UICollectionReusableView>(reusableViewType: T.Type,
                                                      ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                      bundle: Bundle? = nil) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T? {
        if Bundle(for: type).path(forResource: type.className, ofType: "nib") != nil {
            register(cellType: type, bundle: Bundle(for: type))
        } else {
            register(type, forCellWithReuseIdentifier: type.className)
        }
        
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T
    }

    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T? {
        register(reusableViewType: type, bundle: Bundle(for: type))
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as? T
    }

    func defaultCollectionViewCell(for indexPath: IndexPath) -> UICollectionViewCell {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionView.kDefaultIdentifier)
        return dequeueReusableCell(withReuseIdentifier: UICollectionView.kDefaultIdentifier, for: indexPath)
    }
}
