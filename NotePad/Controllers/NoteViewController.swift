//
//  EditViewController.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit

class NoteViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var note = Note()
    let dbManager = DataBaseManager.shared
    
    override func viewDidLoad(){
        super.viewDidLoad()
       
        titleLabel.text = note.title
        bodyLabel.text = note.body
    }
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        UIView.setAnimationsEnabled(false)
        performSegue(withIdentifier: "editAnExistingNote", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAnExistingNote"{
            let destinationVC = segue.destination as! EditViewController
            destinationVC.note = note
        }
    }
}
