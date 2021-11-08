//
//  ViewController.swift
//  NotesApp
//
//  Created by ZHONGTAO REN on 24/8/21.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notesTable: UITableView!
    
    var notes = [Note]()
    
    // MARK: - Segue Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "updateNoteSegue" {
            vc.note = notes[notesTable.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    // MARK: - LifeCycle Hooks
    
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        APIFunctions.functions.delegate = self
        
        notesTable.delegate = self
        notesTable.dataSource = self
    }
    
    // MARK: - TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath) as! NotePrototypeCell
        let note = notes[indexPath.row]
        
        cell.titleLabel.text = note.title
        cell.noteLabel.text = note.note
        cell.dateLabel.text = note.date
        
        return cell
    }
}

// MARK: - Custom Delegate

protocol DataDelegate {
    func updateArray(newArray: String)
}

extension ViewController: DataDelegate {
    
    func updateArray(newArray: String) {
        
        do {
            
            notes = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            
        } catch {
            
            print("Failed to decode!")
            
        }
        
        self.notesTable?.reloadData()
    }
}
