//
//  AddContactView.swift
//  SplitwiseLab
//
//  Created by Felipe Ramirez Vargas on 30/3/21.
//

import SwiftUI

struct AddContactView: View {
    
    @State var nameContact: String = ""
    @State var numberContact: String = ""
    @State var amount: String = ""
    @State var currency: String = ""
    @State var amountType: String = ""
    
    let currencies = ["Dolar", "Colon"]
    let types = ["Debit", "Credit"]
    
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        //NavigationView{
        VStack{
            Form{
                Text("Contact name")
                TextField("Name", text: $nameContact)
                Text("Contact number")
                TextField("Number", text: $numberContact)
                Text("Total amount")
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                Picker("Currency", selection: $currency){
                    ForEach(currencies, id: \.self){ text in
                        Text(text)
                    }
                }
                Picker("Amount type", selection: $amountType){
                    ForEach(types, id: \.self){ text in
                        Text(text)
                    }
                }
            }
            Button(action:save){
                HStack{
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
            }
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(15.0)
        }
        .toolbar{
            ToolbarItem(placement: .principal){
                VStack{
                    Text("Add Task").font(.subheadline)
                }
            }
        }
//      }
    
    }
    
    func save(){
        self.coreDataVM.saveContact(name: nameContact, number: numberContact, amount: amount, currency: currency, type: amountType)
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}
