//
//  ContentView.swift
//  DANavigationSplitView
//
//  Created by Danilo Altheman on 10/03/23.
//

import SwiftUI

struct Contact: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var birthdate: Date?
    var email: String?
    var phone: String?
}

class Contacts: ObservableObject {
    @Published var sample = [
        Contact(name: "Danilo do Carmo Altheman", birthdate: DateFormatter().date(from: "20/08/1978"), email: "daltheman@gmail.com", phone: "11 98879-4320"),
        Contact(name: "Luigi Francesco Godoi Altheman", birthdate: DateFormatter().date(from: "20/08/1978"), email: "lufragoal@gmail.com", phone: "11 98879-4320")
    ]
}

struct ContactDetail: View {
    @EnvironmentObject var contacts: Contacts
    let selectedContact: Contact.ID?
    
    // Computed property
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    var body: some View {
        Form {
            if let contact = contacts.sample.filter {$0.id == selectedContact} {
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(contact.first!.name)")
                    Text(contact.first!.email ?? "Empty")
                    Text(contact.first!.phone ?? "Empty")
                    Text(dateFormatter.string(from: contact.first!.birthdate ?? Date.now))
                }
                .frame(width: 300)
            }
        }
    }
}

struct ContentView: View {
    @State private var selectedContact: Contact.ID?
    @StateObject var contacts = Contacts()
    
    var body: some View {
        NavigationSplitView {
            List(contacts.sample, selection: $selectedContact) { contact in
                Text(contact.name)
            }
        } detail: {
            if let selectedContact {
                
                ContactDetail(selectedContact: selectedContact)
                    .frame(width: 300)
            }
        }
        .environmentObject(contacts)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
