//
//  ContentView.swift
//  Shared
//
//  Created by Babul Raj on 18/03/22.
//

import SwiftUI

struct User: Identifiable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName > rhs.firstName
    }
    
    var id = UUID()
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    let users = [User(firstName: "bab", lastName: "Raj"),User(firstName: "babu", lastName: "Raj1"),User(firstName: "babe", lastName: "Raj2"),User(firstName: "babff", lastName: "Raj3")].sorted()
    
    let list = [2,6,3,4,5]
   
    var body: some View {
        VStack {
       
            List(users) {
            item in
            Text(item.firstName)
            }.padding(10)
            Text("Save me").onTapGesture {
                
                let url = getDocumenURL().appendingPathComponent("message.text")
                do {
                    try "lol hiiii".write(to:url , atomically: true, encoding: .utf8)
                } catch {
                    
                }
                
                let input = try? (String(contentsOf: url))
                print(input)
                
            }
        }.padding(.vertical)
    }
    
    func getDocumenURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
