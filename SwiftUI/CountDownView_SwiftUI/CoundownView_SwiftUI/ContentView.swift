//
//  ContentView.swift
//  CoundownView_SwiftUI
//
//  Created by Babul Raj on 12/10/22.
//

import SwiftUI

struct CountDownView: View {
    var title: String
    var buttonTitle: String
    var endTimeInterval: TimeInterval
    var colour: Color
    var iconName: String?
    var completion: ()->()
 
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
    
    @State private var hour1: String = ""
    @State private var hour2: String = ""
    @State private var min1: String = ""
    @State private var min2: String = ""
    @State private var sec1: String = ""
    @State private var sec2: String = ""
    @State private var isCountDownFinished = false
 
    func updateCountDown() {
        let diff = endTimeInterval - Date().timeIntervalSince1970
        
        if diff <= 0 {
            reset()
            return
        }
        
        let diffDate = Date(timeIntervalSince1970: diff) - 1800
        let calender = Calendar.current
        let hour = calender.component(.hour, from: diffDate)
        let min = calender.component(.minute, from: diffDate)
        let sec = calender.component(.second, from: diffDate)
        
        hour1 = String(format: "%d", hour/10)
        hour2 = String(format: "%d", hour%10)
        
        min1 = String(format: "%d", min/10)
        min2 = String(format: "%d", min%10)
        
        sec1 = String(format: "%d", sec/10)
        sec2 = String(format: "%d", sec%10)
    }
    
    private func reset() {
        self.timer.upstream.connect().cancel()
        hour1 = ""
        hour2 = ""
        min1 = ""
        min2 = ""
        sec1 = ""
        sec2 = ""
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack() {
                HStack {
                    if iconName != nil {
                        AsyncImage(url: nil)
                            .frame(width: 16, height: 16)
                    }
                    Spacer()
                        .frame(width:4)
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                Spacer()
                    .frame(height: 16)
                ZStack {
                    HStack(alignment:.center, spacing:4) {
                        CountDownComponent(title: "Minutes", values: [min1,min2])
                        VStack {
                            Text(":")
                                .font(.body)
                                .foregroundColor(.gray)
                            
                            Spacer()
                                .frame(height:35)
                        }
                        
                        CountDownComponent(title: "Seconds", values: [sec1,sec2])
                    }
                }
                
                Spacer()
                    .frame(height: 32)
                Button(buttonTitle) {
                    completion()
                }
                .frame(width: 100, height: 36)
                .background(colour)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.body)
            }
            .frame(height:250)
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
        .onReceive(timer) { val in
            updateCountDown()
        }
    }
}

struct CheckPointView_Previews: PreviewProvider {
    @State static var val = false

    static var previews: some View {
        CountDownView(title: "", buttonTitle: "", endTimeInterval: 300, colour: .red, iconName: "", completion:{})
    }
}

struct CountDownComponent: View {
    var title: String
    var values:[String]
    
    var body: some View {
        VStack(spacing:16) {
                HStack {
                    ForEach(0..<2) {
                        index in ZStack {
                            Rectangle()
                                .frame(width: 42, height: 52)
                                .cornerRadius(10)
                            .foregroundColor(Color(red: 246/255, green: 246/255, blue: 246/255))
                           // .background(.thinMaterial)

                            Text(values[index])
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                    }
                }
             Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

