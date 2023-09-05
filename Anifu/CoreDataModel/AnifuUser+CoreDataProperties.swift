//
//  AnifuUser+CoreDataProperties.swift
//  Anifu
//
//  Created by Indocyber on 01/09/23.
//
//

import Foundation
import CoreData


extension AnifuUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnifuUser> {
        return NSFetchRequest<AnifuUser>(entityName: "AnifuUser")
    }

    @NSManaged public var animePreference: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var savedAnime: NSSet?

}

// MARK: Generated accessors for savedAnime
extension AnifuUser {

    @objc(addSavedAnimeObject:)
    @NSManaged public func addToSavedAnime(_ value: SavedAnime)

    @objc(removeSavedAnimeObject:)
    @NSManaged public func removeFromSavedAnime(_ value: SavedAnime)

    @objc(addSavedAnime:)
    @NSManaged public func addToSavedAnime(_ values: NSSet)

    @objc(removeSavedAnime:)
    @NSManaged public func removeFromSavedAnime(_ values: NSSet)

}

extension AnifuUser : Identifiable {

}
