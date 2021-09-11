//
//  DataBaseManager.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit
import CoreData

protocol DataBaseManagerDelegate {
    func updateUI(note: Note)
}

struct DataBaseManager{

var delegate: DataBaseManagerDelegate?
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let request: NSFetchRequest<Note> = Note.fetchRequest()

func saveNotes(){
    do{
        try context.save()
    }catch{
        print("Error while saving data")
    }
}
    
func loadNote(){
        
}

func loadNote(with currentNote: Note){
   
    request.predicate = NSPredicate(format: "body == %@", argumentArray: [currentNote])
    do{
        let notes = try context.fetch(request)
        delegate?.updateUI(note: notes[0])
    }catch{
        print("Something went wrong while retrieving data")
    }
}
    
    func loadAllNotes()->[Note]{
        var notes = [Note]()
        do{
            notes = try context.fetch(request)
        }catch{
            print("Something went wrong while retrieving data")
        }
        return notes
    }
}
