//
//  LoadingView.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading......")
            ProgressView()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
