//
//  MainScreenPresenter.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 19.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import Foundation


class MainScreenPresenter: IMainPresenter {
    private weak var view: IMainView?
    private var storeService: IMainStoreService = {
        let service = StoreService()
        return service
    }()
    
    init(view: IMainView) {
        self.view = view
    }
    init() {
    }
    
    func createItem(item: String) {
        storeService.createNote(title: item)
        reloadData()
    }
    
    func deleteItem(item: TheNoteListItem) {
        storeService.deleteNote(item: item)
        reloadData()
    }
    
    func updateItem(item: TheNoteListItem, newTitle: String) {
        storeService.updateNote(item: item, newTitle: newTitle)
        reloadData()
    }
    
    func loadAllNote() -> [TheNoteListItem] {
        let items = storeService.getItems()
        return items
    }

    func reloadData() {
        view?.reloadData()
    }
    
    
}

