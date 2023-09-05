//
//  AnifuFontPicker.swift
//  Anifu
//
//  Created by Indocyber on 19/07/23.
//

import Foundation
import UIKit

public class AnifuFontPicker {
    public static let pick = AnifuFontPicker()
    
    var bodyText: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    var highlightText: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    var superHighlightText: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .black)
    }
    
    var titleText: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
}
