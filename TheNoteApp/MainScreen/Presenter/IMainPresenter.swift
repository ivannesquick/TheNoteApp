//
//  IMainPresenter.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 19.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation

protocol IMainPresenter {
    func createItem(item: String)
    func deleteItem(item: TheNoteListItem)
    func updateItem(item: TheNoteListItem, newTitle: String)
    func loadAllNote() -> [TheNoteListItem]
    func reloadData() 
}
