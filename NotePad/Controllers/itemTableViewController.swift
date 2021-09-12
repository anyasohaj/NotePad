//
//  itemTableViewController.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit

class itemTableViewController: UITableViewController{
    
    let dbManager = DataBaseManager.shared
    var notes: [Note] = [Note]()
   
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editNewNote", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "noteCell")
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    
    func loadData(){
        self.notes = self.dbManager.loadAllNotes()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToNote", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNote"{
            let destinationVC = segue.destination as! NoteViewController
            if let selectedRow = tableView.indexPathForSelectedRow?.row{
                
                destinationVC.note = notes[selectedRow]
            }
        }
    }
    
}
