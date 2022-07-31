//
//  VideoDetailsPractice.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 28/05/22.
//

import SwiftUI

struct VideoDetailsPractice: View {
    var video: Video
    
    var body: some View {
        VStack(spacing:20) {
            Spacer()
            Image(video.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .cornerRadius(10)
            
            Text(video.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .font(.title2)
            
            HStack(spacing:40) {
                Label("\(video.viewCount)", systemImage: "eye.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text(video.description)
                .font(.body)
                .padding()
            Spacer()
            Link(destination: video.url) {
                Text("Watch now")
                    .bold()
                    .frame(width: 280, height: 44, alignment: .center)
                    .background(.red)
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(10)
                    .padding()
             }
        }
    }
}

struct VideoDetailsPractice_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VideoDetailsPractice(video: VideoList.topTen.first!)
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}
