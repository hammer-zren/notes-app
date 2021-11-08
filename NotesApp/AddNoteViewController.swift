//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by ZHONGTAO REN on 24/8/21.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var note: Note?
    var update = false
    
    // MARK: - UI Actions
    @IBAction func saveClick(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        if titleTextField.text != "" && bodyTextView.text != "" {
            if update {
                APIFunctions.functions.updateNote(id: note!._id, title: titleTextField.text ?? "default title", date: date, note: bodyTextView.text ?? "default note")
            } else {
                APIFunctions.functions.addNote(title: titleTextField.text ?? "default title", date: date, note: bodyTextView.text ?? "default note")
            }
            
            self.navigationController?.popViewController(animated: true)
        } else {
            print("empty title or note")
        }
        
    }
    
    @IBAction func deleteClick(_ sender: Any) {
        
        APIFunctions.functions.deleteNote(id: note!._id)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - LifeCycle Hooks
    override func viewWillAppear(_ animated: Bool) {
        
        if !update {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if update {
            titleTextField.text = note?.title
            bodyTextView.text = note?.note
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
