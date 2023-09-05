//
//  SavedAnime+CoreDataProperties.swift
//  Anifu
//
//  Created by Indocyber on 01/09/23.
//
//

import Foundation
import CoreData


extension SavedAnime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedAnime> {
        return NSFetchRequest<SavedAnime>(entityName: "SavedAnime")
    }

    @NSManaged public var animeName: String?
    @NSManaged public var id: Int64
    @NSManaged public var user: AnifuUser?

}

extension SavedAnime : Identifiable {

}
