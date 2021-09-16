//
//  itemTableViewController.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit
import SwipeCellKit

class itemTableViewController: UITableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let dbManager = DataBaseManager.shared

    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:))))
//
//        var button = tableView.addSubview(UIButton())
    }
   

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editNote", sender: self)
    }
    
    func loadData(){
        self.dbManager.notes = self.dbManager.loadNotes()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote"{
            let destinationVC = segue.destination as! EditViewController
            if let selectedRow = tableView.indexPathForSelectedRow?.row{
                destinationVC.note = self.dbManager.notes[selectedRow]
            }
        }
    }
    
    //MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRows called. Number is \(self.dbManager.notes.count)")
       return self.dbManager.notes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell.textLabel?.text = self.dbManager.notes[indexPath.row].title
       
        return cell
    }
}

//MARK: - SwipeTableViewCell Delegate methods

extension itemTableViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.dbManager.deleteNote(at: indexPath.row)
                //tableView.reloadData()
            }

            return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
