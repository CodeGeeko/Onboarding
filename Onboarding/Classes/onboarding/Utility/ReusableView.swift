import Foundation

public protocol ReusableView: class {}

public extension ReusableView where Self: UITableViewCell {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

public extension ReusableView where Self: UITableViewHeaderFooterView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}

public extension ReusableView where Self: UICollectionViewCell {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

public extension ReusableView where Self: UICollectionReusableView {
    public static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableView {}
