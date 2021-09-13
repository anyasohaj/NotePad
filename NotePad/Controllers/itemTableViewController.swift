//
//  itemTableViewController.swift
//  NotePad
//
//  Created by Balazs Agnes on 11.09.2021.
//

import UIKit

class itemTableViewController: UITableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let dbManager = DataBaseManager.shared
    var notes: [Note] = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(_:))))
        
        var button = tableView.addSubview(UIButton())
    
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editNote", sender: self)
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
        
        performSegue(withIdentifier: "editNote", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNote"{
            let destinationVC = segue.destination as! EditViewController
            if let selectedRow = tableView.indexPathForSelectedRow?.row{
                destinationVC.note = notes[selectedRow]
            }
        }
    }
    
    
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer){
        
       print("LongPressed")
    
    }
    
    func deleteItem(){
        print("Deleting item")
    }
    
  
}
