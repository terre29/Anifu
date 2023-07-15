//
//  AnifuDateFormatter.swift
//  Anifu
//
//  Created by Indocyber on 12/07/23.
//

import Foundation

enum DateFormat {
    case MMyyyy
}

class AnifuDateFormatter: DateFormatter {
    static var shared = AnifuDateFormatter()
    
    func formatDate(format: DateFormat) -> DateFormatter {
        switch format {
        case .MMyyyy:
            dateFormat = "MM yyyy"
        }
        return self
    }
}
