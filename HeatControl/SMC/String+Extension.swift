//
//  String+Extension.swift
//  HeatControl
//
//  Created by Illia Kniaziev on 10.06.2022.
//

import Foundation

extension String {
    
    public func smcKey() -> UInt32? {
        guard self.count == 4 else { return nil }
        
        let value: UInt32 = self.utf8.reduce(0) { sumOfBits, character in
            return sumOfBits << 8 | UInt32(character)
        }
        
        return value
    }

}
