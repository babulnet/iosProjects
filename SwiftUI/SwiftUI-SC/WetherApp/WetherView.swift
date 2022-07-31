//
//  WetherView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 03/04/22.
//

import SwiftUI

struct WetherView: View {
    var weather: ResponseBody
    
    var body: some View {
        VStack {
            Spacer()
                
        Text(weather.name)
           
        }
    }
}

struct WetherView_Previews: PreviewProvider {
    static var previews: some View {
        WetherView(weather: previewWeather)
    }
}
