//
//  Helpers.swift
//
//	Collection of fast helping methods for routine
//
//  Copyright © 2019 alexander.s.lebedev@gmail.com 
//	All rights reserved.
//
//	Last date of edit: 14.11.19


import Foundation

//  MARK: Common methods
final class Common {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//	MARK: Array extensions
extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else { return }
        remove(at: index)
    }
}
