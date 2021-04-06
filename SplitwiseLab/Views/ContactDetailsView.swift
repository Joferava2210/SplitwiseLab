//
//  ContactDetailsView.swift
//  SplitwiseLab
//
//  Created by Felipe Ramirez Vargas on 4/4/21.
//

import SwiftUI

struct ContactDetailsView: View {

    let contact: ContactEntity
    @State var newName: String = ""
    @State var newTelephone: String = ""
    @State var newCurrency: String = ""
    @State var newAmount: String = ""
    @State var newType: String = ""
    
    let currencies = ["Dolar", "Colon"]
    let types = ["Debit", "Credit"]
    
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            Form{
                Text("Name:").bold()
                TextField(contact.name ?? "", text: $newName)
                Text("Number").bold()
                TextField(contact.telephone ?? "", text: $newTelephone)
                Text("Currency").bold()
                Picker("Currency", selection: $newCurrency){
                    ForEach(currencies, id: \.self){ text in
                        Text(text)
                    }
                }
                Text("Amount").bold()
                TextField(contact.amount ?? "", text: $newAmount)
                Text("Type").bold()
                Picker("Amount type", selection: $newType){
                    ForEach(types, id: \.self){ text in
                        Text(text)
                    }
                }
            }
            Button(action:update){
                HStack{
                    Image(systemName: "plus.circle.fill")
                    Text("Update")
                }
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(15.0)
            .toolbar{
                ToolbarItem(placement: .principal){
                    VStack{
                        Text("Contact Details").font(.headline)
                    }
                }
            }
        }
    }
    
    func update(){
        contact.name = newName
        contact.telephone = newTelephone
        contact.currency = newCurrency
        contact.amount = newAmount
        contact.amountType = newType
        self.coreDataVM.updateContact(contact: contact)
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let contact = ContactEntity()
        ContactDetailsView(contact: contact)
    }
}
