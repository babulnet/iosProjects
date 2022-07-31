//
//  SwiftUI-MM.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 19/03/22.
//

import SwiftUI

struct SwiftUI_MM: View {
    var body: some View {
        ZStack {
            
            GeometryReader { gr in
                VStack {
                    Group {
                        HStack {
                            Spacer()
                            Circle()
                                .fill(.secondary)
                                .frame(width: 200, height: 200)
                                .padding([.top, .trailing], -100)
                        }
                        HStack {
                            Circle()
                                .fill(.secondary)
                                .padding(.leading, -200)
                                .frame(width: 200, height: 200)
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.secondary)
                        .frame(height: gr.size.height/2)
                }
            }
        }
    }
}

struct SwiftUI_MM_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUI_MM()
                .previewDevice("iPhone 11")
            SwiftUI_MM()
                .previewDevice("iPod touch (7th generation)")
        }
    }
}
