//
//  TheNoteListItem+CoreDataProperties.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 17.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//
//

import Foundation
import CoreData


extension TheNoteListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TheNoteListItem> {
        return NSFetchRequest<TheNoteListItem>(entityName: "TheNoteListItem")
    }

    @NSManaged public var title: String?

}
