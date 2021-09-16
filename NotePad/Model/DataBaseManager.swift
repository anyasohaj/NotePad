//
//  DataBaseManager.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit
import CoreData

class DataBaseManager {
    
    static let shared = DataBaseManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    var notes = [Note]()
    
    private init(){}
    
    func saveNotes(){
        do{
            try context.save()
        }catch{
            print("Error while saving data")
        }
    }
    
    func deleteNote(at index: Int){
        print("dbManager deleteNote method")
        context.delete(notes[index])
        notes.remove(at: index)
        print("remaining objects are \(notes.count)")
        saveNotes()
    }
    
    func loadNote(with currentNote: Note){
        print("loadNote()")
        request.predicate = NSPredicate(format: "body == %@", currentNote)
        loadNotes()
    }
    
    
    func loadNotes()->[Note]{
    print("loadNotes()->[Note]")
        
        do{
            self.notes = try context.fetch(request)
        }catch{
            print("This is my personal error while fetching notes data")
        }
        
        return notes
    }
}
