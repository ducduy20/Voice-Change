//
//  Font+Extension.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 04/08/2022.
//

import Foundation
import SwiftUI

enum FontStyle: String{
    case medium = "San Francisco Display - Medium"
    case semibold = "San Francisco Display - Semibold"
    case bold = "San Francisco Display - Bold"
    case regular = "San Francisco Display - Regular"
    
}
extension Font{
    static func setFont(_ fontStyle: FontStyle = .medium, size:CGFloat = 16) -> Font{
        return Font.custom(fontStyle.rawValue, size: size)
    }
}
