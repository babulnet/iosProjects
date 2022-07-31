//
//  VideoDetalView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 19/03/22.
//

import SwiftUI

struct VideoDetalView: View {
    var video: Video
    let button: Text = Text("Watch Now")

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height:150)
                .cornerRadius(12)
            
            Text(video.title)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack() {
                Label("\(video.viewCount)", systemImage: "eye.fill")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                
                Text(video.uploadDate)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            
            Text(video.description)
                .font(.body)
                .padding()
            
            Spacer()
           
            Link(destination: video.url) {
                button
                    .bold()
                    .font(.title2)
                    .frame(width: 280, height: 44, alignment: .center)
                    .background(Color(.systemRed))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding([.leading, .bottom, .trailing],10)
            }.onTapGesture {
                
            }
        }
    }
}

struct VideoDetalView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetalView(video: VideoList.topTen[0])
            .previewDevice("iPhone 12 Pro Max")
    }
}
