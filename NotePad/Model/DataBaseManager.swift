//
//  DataBaseManager.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit
import CoreData

class DataBaseManager{
    
    static let shared = DataBaseManager()
    var notes = [Note]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<Note> = Note.fetchRequest()
    
    private init(){
      
    }
    
    func saveNotes(){
        do{
            try context.save()
        }catch{
            print("Error while saving data")
        }
    }
    
    
 func loadNote(with currentNote: Note){
        
        request.predicate = NSPredicate(format: "body == %@", argumentArray: [currentNote])
        do{
            self.notes = try context.fetch(request)
            
        }catch{
            print(error)
        }
    }
    
    
func loadAllNotes()->[Note]{
        
        do{
            self.notes = try context.fetch(request)
        }catch{
            print(error)
        }
        
        return notes
    }
}
