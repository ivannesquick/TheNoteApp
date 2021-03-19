//
//  StoreService.swift
//  TheNoteApp
//
//  Created by Neskin Ivan on 19.03.2021.
//  Copyright © 2021 Neskin Ivan. All rights reserved.
//

import UIKit


class StoreService: IMainStoreService {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [TheNoteListItem]()
    
    func deleteNote(item: TheNoteListItem) {
           context.delete(item)
           
           do {
               try context.save()
           } catch {
               
           }
       }
       
       func updateNote(item: TheNoteListItem, newTitle: String) {
           item.title = newTitle
           
           do {
               try context.save()
           } catch {
               
           }
       }
       
       func createNote(title: String) {
           let newNote = TheNoteListItem(context: context)
           newNote.title = title
           do {
               try context.save()
           } catch {
               
           }
       }
    
    func getItems() -> [TheNoteListItem] {
        
        do {
            items = try context.fetch(TheNoteListItem.fetchRequest())
            return items
        }catch {
            print("error")
        }
        return items
    }
}
