//
//  APIFunctions.swift
//  NotesApp
//
//  Created by ZHONGTAO REN on 24/8/21.
//

import Foundation
import Alamofire

struct Note: Decodable {
    var _id: String
    var title: String
    var date: String
    var note: String
}

class APIFunctions {
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    
    func fetchNotes() {
        AF.request("http://192.168.1.167:8081/fetch").response {
            response in
            
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    func addNote(title:String, date:String, note:String) {
        AF.request("http://192.168.1.167:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).response {
            response in
            print(String(data: response.data!, encoding: .utf8)!)
        }
    }
    
    func updateNote(id: String, title:String, date:String, note:String) {
        AF.request("http://192.168.1.167:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["id": id, "title": title, "date": date, "note": note]).response {
            response in
            print(String(data: response.data!, encoding: .utf8)!)
        }
    }
    
    func deleteNote(id:String) {
        AF.request("http://192.168.1.167:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id": id]).response {
            response in
            print(String(data: response.data!, encoding: .utf8)!)
        }
    }
}
