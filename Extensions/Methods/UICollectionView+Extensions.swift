//
//  UICollectionView+Extensions.swift
//  Extensions
//
//  Created by 李文康 on 2023/10/25.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

// MARK: - Reuse
extension Zonable where Base: UICollectionView {
    func register<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        base.register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func register<Cell: UICollectionViewCell>(nibClass: Cell.Type) {
        let nibName = String(describing: nibClass)
        let bundle = Bundle(for: nibClass)
        let nib = UINib(nibName: nibName, bundle: bundle)
        base.register(nib, forCellWithReuseIdentifier: nibName)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        // swiftlint:disable:next force_cast
        return base.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }

    func register<View: UICollectionReusableView>(headerClass: View.Type) {
        base.register(
            headerClass,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: headerClass)
        )
    }

    func register<View: UICollectionReusableView>(headerNibClass: View.Type) {
        let nibName = String(describing: headerNibClass)
        let bundle = Bundle(for: headerNibClass)
        let nib = UINib(nibName: nibName, bundle: bundle)
        base.register(
            nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: nibName
        )
    }

    func dequeueReusableHeader<View: UICollectionReusableView>(for indexPath: IndexPath) -> View {
        let identifier = String(describing: View.self)
        return base.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: identifier,
            for: indexPath
        ) as! View // swiftlint:disable:this force_cast
    }

    func register<View: UICollectionReusableView>(footerClass: View.Type) {
        base.register(
            footerClass,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: String(describing: footerClass)
        )
    }

    func register<View: UICollectionReusableView>(footerNibClass: View.Type) {
        let nibName = String(describing: footerNibClass)
        let bundle = Bundle(for: footerNibClass)
        let nib = UINib(nibName: nibName, bundle: bundle)
        base.register(
            nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: nibName
        )
    }

    func dequeueReusableFooter<View: UICollectionReusableView>(for indexPath: IndexPath) -> View {
        let identifier = String(describing: View.self)
        return base.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: identifier,
            for: indexPath
        ) as! View // swiftlint:disable:this force_cast
    }
}
