//
//  VideoListPractice.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 28/05/22.
//

import SwiftUI

struct VideoListPractice: View {
    var videoList = VideoList.topTen
   
    var body: some View {
        NavigationView {
            List(videoList) { item in
                NavigationLink(destination: VideoDetalView(video: item)) {
                    VideoCell(item: item)
                }
            }.navigationTitle("My Top 10 Videos")
        }
    }
}

struct VideoCell : View {
    var item: Video
   
    var body: some View {
        HStack {
            Image(item.imageName).resizable().aspectRatio(contentMode: .fit)
                .frame(height: 70, alignment: .center)
                .cornerRadius(4)
                .padding(.vertical,10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                Text(item.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct VideoListPractice_Previews: PreviewProvider {
    static var previews: some View {
        VideoListPractice()
    }
}
