//
//  NoteViewController.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit
import CoreData

class EditViewController: UIViewController{
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dbManager : DataBaseManager = DataBaseManager()
    var note : Note?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentNote = note{
            titleTextField.text = currentNote.title
            bodyTextField.text = currentNote.body
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.setAnimationsEnabled(true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let currentNote: Note = Note(context: context)
        currentNote.title = titleTextField.text
        currentNote.body = bodyTextField.text
        currentNote.date = Date()
        dbManager.saveNotes()
        _ = navigationController?.popViewController(animated: true)
    }
    

}
