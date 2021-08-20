//
//  Bundle+Geeko.swift
//  Onboarding
//
//  Created by Kuldeep Bhatt on 2021/08/20.
//

import Foundation

extension Bundle {
    public static func getBundle<Class: NSObject>(for class: Class.Type, resourceName: String, ext: String) -> Bundle? {
        let bundle = Bundle(for: Class.self)
        if let url = bundle.url(forResource: resourceName, withExtension: ext) {
            return Bundle(url: url)
        }
        return bundle
    }
}
