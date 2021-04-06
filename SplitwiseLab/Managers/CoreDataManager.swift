//
//  CoreDataManager.swift
//  SplitwiseLab
//
//  Created by Felipe Ramirez Vargas on 30/3/21.
//

import CoreData

class CoreDataManager{
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "InfoDataModel")
        persistentContainer.loadPersistentStores{ (description, error) in
            if let error = error{
                print("Unable to load Core Data Store \(error)")
            }
        }
    }
    
    func saveContact(name: String, number: String, amount: String, currency: String, type: String){
        let contact = ContactEntity(context: persistentContainer.viewContext)
        contact.name = name
        contact.telephone = number
        contact.amount = amount
        contact.currency = currency
        contact.amountType = type
        
        if let result = try? persistentContainer.viewContext.save(){
            print("Success to save contact")
        }else{
            print("Failed to save contact")
        }
    }
    
    func updateContact(newContact: ContactEntity){
        let contact = ContactEntity(context: persistentContainer.viewContext)
        
        persistentContainer.viewContext.performAndWait {
            contact.name = newContact.name
            contact.telephone = newContact.telephone
            contact.amount = newContact.amount
            contact.currency = newContact.currency
            contact.amountType = newContact.amountType
            try? persistentContainer.viewContext.save()
        }
        
        if let result = try? persistentContainer.viewContext.save(){
            print("Success to save contact")
        }else{
            print("Failed to save contact")
        }
    }
    
    func getAllContacts() -> [ContactEntity]{
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        
        if let result = try? persistentContainer.viewContext.fetch(fetchRequest){
            print("Success to retrieve all contacts")
            return result
        }
        print("Failed to retrieve all contacts")
        return []
    }
    
    func deleteContact(contact: ContactEntity){
        persistentContainer.viewContext.delete(contact)
        
        if let result = try? persistentContainer.viewContext.save(){
            print("Success to delete contact")
        }else{
            persistentContainer.viewContext.rollback()
            print("Failed to delete contact")
        }
    }
    
}
