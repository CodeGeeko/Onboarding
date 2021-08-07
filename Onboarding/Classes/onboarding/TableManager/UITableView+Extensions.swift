import UIKit

public extension UITableView {
    ///
    /// The same benefits as cell(ofType:) but it also eliminates the "guard let..." and "return cell" boilerplate in every "configure...Cell()" method
    ///
    /// Example without reuse identifier:
    /// return tableView.dequeueCell(ofType: MEMTableViewCell.self, indexPath: indexPath) { (cell) in
    ///     cell.selectionStyle = .none
    /// }
    ///
    /// Example with reuse identifier:
    /// return tableView.dequeueCell(ofType: MEMTableViewCell.self, reuseIdentifier: kCellReuseIdentifier, indexPath: indexPath) { (cell) in
    ///     cell.selectionStyle = .none
    /// }
    ///
    /// Example without configure block:
    /// return tableView.dequeueCell(ofType: MEMTableViewCell.self, indexPath: indexPath)
    ///
    public func dequeueCell<CellType : UITableViewCell>(ofType cellType: CellType.Type, reuseIdentifier: String = CellType.defaultReuseIdentifier, indexPath: IndexPath, configure: ((CellType) -> Void)? = nil) -> UITableViewCell {
        let cell = self.cell(ofType: cellType, reuseIdentifier: reuseIdentifier, indexPath: indexPath)
        if let configure = configure {
            configure(cell)
        }
        return cell
    }
    
    ///
    /// You do not need to register the cell, nor declare and pass in a reuse identifier (but you can if you want)
    ///
    /// Example without reuse identifier:
    /// tableView.cell(ofType: MEMTableViewCell.self, indexPath: indexPath)
    ///
    /// Example with reuse identifier:
    /// tableView.cell(ofType: MEMTableViewCell.self, reuseIdentifier: kCellReuseIdentifier, indexPath: indexPath)
    ///
    func cell<CellType : UITableViewCell>(ofType cellType: CellType.Type, reuseIdentifier: String = CellType.defaultReuseIdentifier, indexPath: IndexPath, bundle: Bundle = Bundle.main) -> CellType {
        if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? CellType {
            return cell
        }
        register(nib(for: cellType, bundle: bundle), forCellReuseIdentifier: reuseIdentifier)
        guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
            register(CellType.self, forCellReuseIdentifier: reuseIdentifier)
            guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
                return CellType()
            }
            return registeredCell
        }
        return registeredCell
    }
    
     ///
     /// Can be used to safely load cells that do not have nibs
     /// No need to register the cell or declare a reuse identifier, but the latter is available if needed
     ///
     /// Example without reuse identifier:
     /// tableView.dequeuedCell(ofType: MEMTableViewCell.self, indexPath: indexPath)
     ///
     /// Example with reuse identifier:
     /// tableView.dequeuedCell(ofType: MEMTableViewCell.self, reuseIdentifier: kCellReuseIdentifier, indexPath: indexPath)
     ///
    func dequeuedCell<CellType : UITableViewCell>(ofType cellType: CellType.Type, reuseIdentifier: String = CellType.defaultReuseIdentifier, indexPath: IndexPath, bundle: Bundle = Bundle.main) -> CellType {
         if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) as? CellType { return cell }
         if Bundle(for: cellType).path(forResource: cellType.className, ofType: "nib") != nil {
            let nib = UINib(nibName: cellType.className, bundle: Bundle(for: cellType)) 
             register(nib, forCellReuseIdentifier: reuseIdentifier)
         } else {
             register(cellType, forCellReuseIdentifier: reuseIdentifier)
         }
         guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
             register(CellType.self, forCellReuseIdentifier: reuseIdentifier)
             guard let registeredCell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
                 return CellType()
             }
             return registeredCell
         }
         return registeredCell
     }
    
    ///
    /// You do not need to register the view, nor declare and pass in a reuse identifier (but you can if you want)
    ///
    /// Example without reuse identifier:
    /// tableView.headerFooterView(ofType: MEMTableViewSectionHeaderFooterView.self)
    ///
    /// Example with reuse identifier:
    /// tableView.headerFooterView(ofType: MEMTableViewSectionHeaderFooterView.self, reuseIdentifier: kCellReuseIdentifier)
    ///
    func headerFooterView<ViewType : UITableViewHeaderFooterView>(ofType viewType: ViewType.Type, reuseIdentifier: String = ViewType.defaultReuseIdentifier, bundle: Bundle = Bundle.main) -> ViewType? {
        if let view = dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? ViewType {
            return view
        }
        register(nib(for: viewType, bundle: bundle), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        return dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? ViewType
    }
    
    private func nib<NibType : UIView>(for nibType: NibType.Type, bundle: Bundle) -> UINib {
        let bundle = Bundle(for: nibType)
        if bundle.path(forResource: nibType.className, ofType: "nib") == nil {
            return UINib(nibName: String(describing: nibType), bundle: bundle)
        }
        return UINib(nibName: String(describing: nibType), bundle: Bundle(for: nibType))
    }
}
