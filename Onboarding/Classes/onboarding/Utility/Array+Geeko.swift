//
//  Array+Yoco.swift
//  yocoTest
//
//  Created by Kuldeep Bhatt on 2021/08/07.
//

import Foundation

extension Array {
    mutating func append(_ value: Element, if shouldAppend: Bool) {
        if shouldAppend {
            append(value)
        }
    }

    /// Append value if value is not nil
    ///
    /// - Parameters:
    ///   - value: The value to be added if it is not nil
    mutating func appendIfNotNil(_ value: Element?) {
        if let value = value {
            append(value)
        }
    }
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
