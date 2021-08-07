import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

public struct ClassInfo: CustomStringConvertible, Equatable {
    public let classObject: AnyClass
    public let moduleAndClassName: String

    public init?(_ classObject: AnyClass?) {
        guard classObject != nil else {
            return nil
        }

        self.classObject = classObject!
        let cName = class_getName(classObject)
        self.moduleAndClassName = String(cString: cName)
    }

    public var superclassInfo: ClassInfo? {
        let superclassObject: AnyClass? = class_getSuperclass(self.classObject)
        return ClassInfo(superclassObject)
    }

    public var description: String {
        return self.moduleAndClassName
    }

    public var className: String {
        return self.moduleAndClassName.components(separatedBy: ".").last ?? self.moduleAndClassName
    }

    public static func == (lhs: ClassInfo, rhs: ClassInfo) -> Bool {
        return lhs.moduleAndClassName == rhs.moduleAndClassName
    }

    public static func subclassInfo(for superclassInfo: ClassInfo) -> [ClassInfo] {
        var count = UInt32(0)
        guard let classListPointer = objc_copyClassList(&count) else { return [] }

        return UnsafeBufferPointer(start: classListPointer, count: Int(count))
            .compactMap(ClassInfo.init)
            .filter { $0.superclassInfo == superclassInfo }
    }
}
