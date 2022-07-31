//
//  ForDSAlgos.swift
//  SwiftUIlESSONSwITHniTHIN
//
//  Created by Babul Raj on 15/06/22.
//

import SwiftUI

struct ForDSAlgos: View {
    @State var inputValue: Int = 0
    @State var output: String = ""
    @State var inputArray: [Int] = []
    @State var textfieldOP: String = ""
    
    var body: some View {
        
        VStack(spacing:10) {
            Text("Use This")
            TextField("input", text: $textfieldOP)
                .padding()
                .border(.brown)
                .keyboardType(.numberPad)
                .onChange(of: textfieldOP) { newValue in
                    inputArray.append(Int(newValue) ?? 0)
                }
            
            Button("Calculate") {
                let out = DSALgoSolutions().romanToNumber(input: "MCMXCIV")
                output = String(out)
                
                let bb = textfieldOP.compactMap { char in
                    return Int(String(char))
                }
                
                let _ = LL(array: bb)
            }
            Text("Answer:  \(output)")
                .background(.clear)
                .font(.headline)
            
        }.padding()
    }
}

struct ForDSAlgos_Previews: PreviewProvider {
    static var previews: some View {
        ForDSAlgos()
    }
}
