//
//  ContentView.swift
//  SplitwiseLab
//
//  Created by Felipe Ramirez Vargas on 30/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("status") var logged = false
    @ObservedObject var coreDataVM = CoreDataViewModel()
    @State var totalAmountCol: Int = 0
    @State var totalAmountDol: Int = 0
    
    var body: some View {
        if logged {
            NavigationView{
                VStack{
                    HStack{
                        Text("Total amount colones:")
                            .padding(.leading, 20)
                        Spacer()
                        Text("\(totalAmountCol)")
                            .padding(.trailing, 20)
                    }
                    Spacer()
                    HStack{
                        Text("Total amount dolares:")
                            .padding(.leading, 20)
                        Spacer()
                        Text("\(totalAmountDol)")
                            .padding(.trailing, 20)
                    }
                    List{
                        ForEach(coreDataVM.contacts, id: \.self){ contact in
                            NavigationLink(
                                destination: ContactDetailsView(contact: contact),
                                label: {
                            HStack{
                                Text(contact.name ?? "")
                                Spacer()
                                VStack(alignment: .leading, spacing: nil){
                                    Text(contact.currency ?? "Colon")
                                    if(contact.amountType == "Debit"){
                                        Text("-\(contact.amount ?? "")")
                                    }else{
                                        Text("+\(contact.amount ?? "")")
                                    }
                                    
                                }
                            }
                            .onAppear(perform:{
                                self.sumaTotal(amount: contact.amount ?? "", currency: contact.currency ?? "Colon",
                                               type: contact.amountType ?? "Credit")
                            })
                            
                                }
                            )
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach{ index in
                                let contact = coreDataVM.contacts[index]
                                deleteTotal(amount: contact.amount ?? "", currency: contact.currency ?? "Colon",
                                            type: contact.amountType ?? "Credit")
                                coreDataVM.deleteContact(contact: contact)
                                coreDataVM.getAllContacts()
                            }
                        })
                    }
                }
                .listStyle(SidebarListStyle())
                .navigationTitle("Contacts")
                .navigationBarItems(
                    trailing: NavigationLink(
                        destination: AddContactView()){
                        Image(systemName: "square.and.pencil")
                            .imageScale(.large)
                    }
                )
                .onAppear(perform: {
                    totalAmountCol = 0
                    totalAmountDol = 0
                    self.coreDataVM.getAllContacts()
                })
            }
        }else{
            LoginView()
                .preferredColorScheme(.light)
                .navigationBarHidden(true)
        }
    }
    
    func sumaTotal(amount: String, currency: String, type: String){
        if(currency == "Colon"){
            if(type == "Credit"){
                totalAmountCol += Int(amount) ?? 0
            }else {
                totalAmountCol -= Int(amount) ?? 0
            }
        }else{
            if(type == "Credit"){
                totalAmountDol += Int(amount) ?? 0
            }else {
                totalAmountDol -= Int(amount) ?? 0
            }
            
        }
    }
    
    func deleteTotal(amount: String, currency: String, type: String){
        if(currency == "Colon"){
            if(type == "Credit"){
                totalAmountCol -= Int(amount) ?? 0
            }else {
                totalAmountCol += Int(amount) ?? 0
            }
        }else{
            if(type == "Credit"){
                totalAmountDol -= Int(amount) ?? 0
            }else {
                totalAmountDol += Int(amount) ?? 0
            }
            
        }
    }
    
    func currencyImages(currency: String) -> String{
        switch currency {
        case "Dolar":
            return "3.square"
        case "Colon":
            return "2.square"
        default:
            return "1.square"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
