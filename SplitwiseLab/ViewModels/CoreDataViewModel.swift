//
//  CoreDataViewModel.swift
//  SplitwiseLab
//
//  Created by Felipe Ramirez Vargas on 30/3/21.
//

import Foundation

class CoreDataViewModel: ObservableObject{
    
    @Published var coreDM = CoreDataManager()
    @Published var contacts: [ContactEntity] = [ContactEntity]()
    
    func saveContact(name: String, number: String, amount: String, currency: String, type: String){
        coreDM.saveContact(name: name, number: number, amount: amount, currency: currency, type: type)
    }
    
    func updateContact(contact: ContactEntity){
        coreDM.updateContact(newContact: contact)
    }
    
    func getAllContacts(){
        contacts = self.coreDM.getAllContacts()
    }
    
    func deleteContact(contact: ContactEntity){
        coreDM.deleteContact(contact: contact)
    }
}
