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
    @IBOutlet weak var bodyTextView: UITextView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dbManager : DataBaseManager = DataBaseManager.shared
    var note : Note?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentNote = note{
            titleTextField.text = currentNote.title
            bodyTextView.text = currentNote.body
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.setAnimationsEnabled(true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if note == nil {
              note = Note(context: context)
        }
        note!.title = titleTextField.text
        note!.body = bodyTextView.text
        note!.date = Date()
        dbManager.saveNotes()
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
