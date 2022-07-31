//
//  WelcomeView.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 03/04/22.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: WetherLocationManager
   
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to the wether App")
                    .bold()
                    .font(.title)
                    .padding()
                
                Text("please enter your location to get the weather update")
                    .font(.subheadline)
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(10)
            .symbolVariant(.fill)
            .foregroundColor(.white)

        }.frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
