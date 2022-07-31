//
//  FormView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 04/04/22.
//

import SwiftUI

struct FormView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var dob = Date()
    @State var isNlOn = false
    @State var numberOfLikes = 3
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("DOB", selection: $dob, displayedComponents: .date)
                }
                
                Section("ACTIONS") {
                    Toggle("Send Newsletter", isOn: $isNlOn)
                    Stepper("Number of Likes", value: $numberOfLikes, in: 1...100)
                    Text("I have \(numberOfLikes) likes for this page")
                    Link("terms of Service", destination: URL(string: "https://google.com")!)
                }
                
            }
            .toolbar(content: {
                Button {
                    
                } label: {
                    Text("tap me ")
                }

            })
            .tint(.blue)
            .navigationTitle("Account")
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
