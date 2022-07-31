//
//  MocktestDetailsView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 28/05/22.
//

import SwiftUI

struct MocktestDetailsView: View {
    var mockTest: Model
    var body: some View {
        VStack {
            Image(mockTest.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 210)
                .cornerRadius(12)
            
            Text(mockTest.title)
                .font(.title2)
                .lineLimit(2)
                .padding(.vertical,7)
            
            HStack(spacing:60) {
                Text("Rs.\(mockTest.sellPrice)")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.green)
                
                Text("Rs.\(mockTest.originalPrice)")
                    .font(.title3)
                    .strikethrough()
            }.padding()
            
            HStack(spacing:60) {
                VStack() {
                    Text("360")
                        .font(.title)
                        .bold()
                    Text("MARKS")
                }
                
                VStack() {
                    Text("360")
                        .font(.title)
                        .bold()
                    Text("MARKS")
                }
                
                VStack() {
                    Text("360")
                        .font(.title)
                        .bold()
                    Text("MARKS")
                }
            }
            
            Text(mockTest.description)
                .padding()
            Spacer()
            Link(destination: mockTest.url) {
                Text("Enroll now")
                    .bold()
                    .frame(width: 260, height: 44, alignment: .center)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }.padding()
        }
    }
}

struct MocktestDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MocktestDetailsView(mockTest: ModelList.modelList.first!)
    }
}
