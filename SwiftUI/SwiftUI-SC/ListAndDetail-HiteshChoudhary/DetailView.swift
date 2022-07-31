//
//  DetailView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 18/03/22.
//

import SwiftUI

struct DetailView: View {
    let model: Model
    @State private var tapCount = 0
   
    private var buttonColour: Color {
        return (tapCount % 2 == 0) ? .green : .yellow
    }
   
    var body: some View {
        ScrollView {
            VStack {
                Image(model.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(height: 250)
                    .onTapGesture {
                        tapCount += 1
                    }
                
                Text(model.title)
                    .font(.title2)
                    .lineLimit(2)
                    .padding(.vertical,4)
                
                HStack (spacing:60) {
                    Text(model.sellPrice)
                        .bold()
                        .font(.title3)
                        .foregroundColor(.green)
                    Text(model.originalPrice)
                        .font(.title3)
                        .strikethrough()
                        .padding(.vertical,15)
                }
                
                HStack(spacing:60) {
                    VStack {
                        Text("360")
                            .font(.title)
                            .bold()
                        Text("Marks")
                    }
                    
                    VStack {
                        Text("180")
                            .font(.title)
                            .bold()
                        Text("Minutes")
                    }
                    
                    VStack {
                        Text("220")
                            .font(.title)
                            .bold()
                        Text("Questions")
                    }
                }
                
                Text(model.description)
                    .padding()
                
                Spacer()
                
                Link(destination: model.url) {
                    Text("Enroll Now")
                        .bold()
                        .frame(width: 320, height: 40)
                        .background(buttonColour)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }.padding()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(model: ModelList.modelList[1])
            .previewDevice("iPhone 12 Pro Max")
    }
}
