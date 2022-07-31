//
//  seanAllen.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 19/03/22.
//

import SwiftUI

struct seanAllen: View {
    let videoArray = VideoList.topTen
    
    var body: some View {
        NavigationView {
            List(videoArray) { item in
                NavigationLink {
                    VideoDetalView(video: item)
                } label: {
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height:70)
                            .cornerRadius(10)
                        VStack(alignment:.leading, spacing: 5) {
                            Text(item.title)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .minimumScaleFactor(0.5)
                            Text(item.uploadDate)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }.navigationTitle("My top 10 Videos")
        }
    }
}
 
struct seanAllen_Previews: PreviewProvider {
    static var previews: some View {
        seanAllen()
            .previewDevice("iPhone 11 Pro")
    }
}
