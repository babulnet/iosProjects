//
//  MockTestListView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 28/05/22.
//

import SwiftUI

struct MockTestListView: View {
    var mockTestList:[Model] = ModelList.modelList
    
    var body: some View {
        NavigationView {
            List(mockTestList) { item in
                NavigationLink(destination: MocktestDetailsView(mockTest: item)) {
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 90)
                            .padding(.horizontal,7)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.title)
                                .font(.headline)
                                .fontWeight(.medium)
                            let suff = (item.sellPrice == "FREE") ?  "" : "Rs"
                            
                            Text("\(suff) \(item.sellPrice)")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                    }
                }
            }.navigationBarTitle("Mock Tests")
        }
    }
}

struct MockTestListView_Previews: PreviewProvider {
    static var previews: some View {
        MockTestListView()
    }
}
