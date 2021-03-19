//
//  IMainStoreSecvice.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 19.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation

protocol IMainStoreService {
    func deleteNote(item: TheNoteListItem)
    func updateNote(item: TheNoteListItem, newTitle: String)
    func createNote(title: String)
    func getItems() -> [TheNoteListItem]
}
