//
//  LoadingViewWether.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 03/04/22.
//

import SwiftUI

struct LoadingViewWether: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .frame(maxWidth:.infinity,maxHeight: .infinity)
    }
}

struct LoadingViewWether_Previews: PreviewProvider {
    static var previews: some View {
        LoadingViewWether()
    }
}
