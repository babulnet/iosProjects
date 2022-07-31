//
//  LoadingViewWeather.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 30/05/22.
//

import SwiftUI

struct LoadingViewWeather: View {
    var tint: Color = .white
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(tint)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingViewWeather_Previews: PreviewProvider {
    static var previews: some View {
        LoadingViewWeather()
    }
}
