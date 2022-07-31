//
//  LoadingView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 20/03/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing:40) {
            Text("🐱").font(.system(size: 80))
            ProgressView()
            Text("Getting cats...")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
