//
//  UITableView+Extensions.swift
//  Extensions
//
//  Created by 李文康 on 2023/10/25.
//  Copyright © 2023 FunctionMaker. All rights reserved.
//

// MARK: - Reuse
extension Zonable where Base: UITableView {
    func register<Cell: UITableViewCell>(cellClass: Cell.Type) {
        base.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func register<Cell: UITableViewCell>(nibClass: Cell.Type) {
        let nibName = String(describing: nibClass)
        let bundle = Bundle(for: nibClass)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return base.register(nib, forCellReuseIdentifier: nibName)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        // swiftlint:disable:next force_cast
        return base.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
    }

    func register<View: UITableViewHeaderFooterView>(viewClass: View.Type) {
        let identifier = String(describing: viewClass)
        return base.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func register<View: UITableViewHeaderFooterView>(nibClass: View.Type) {
        let nibName = String(describing: nibClass)
        let bundle = Bundle(for: nibClass)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return base.register(nib, forHeaderFooterViewReuseIdentifier: nibName)
    }

    func dequeueReusableView<View: UITableViewHeaderFooterView>() -> View {
        let identifier = String(describing: View.self)
        // swiftlint:disable:next force_cast
        return base.dequeueReusableHeaderFooterView(withIdentifier: identifier) as! View
    }
}

// MARK: - Scroll
extension Zonable where Base: UITableView {
    func scrollToBottom(position: UITableView.ScrollPosition = .none, animated: Bool = true) {
        let sectionsCount = base.numberOfSections
        if sectionsCount == 0 { return }
        let sectionIdx = sectionsCount - 1
        let lastSectionRowsCount = base.numberOfRows(inSection: sectionIdx)
        if lastSectionRowsCount == 0 { return }
        let indexPath = IndexPath(row: lastSectionRowsCount - 1, section: sectionIdx)
        base.scrollToRow(at: indexPath, at: position, animated: animated)
    }
}
