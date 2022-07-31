//
//  WelcomeViewWeather.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 30/05/22.
//

import SwiftUI
import CoreLocationUI

struct WelcomeViewWeather: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 50) {
                Text("Welcome to the Weather App")
                    .font(.title)
                    .bold()
                Text("Please share your current location to get weather in your area")
                    .padding()
            }.multilineTextAlignment(.center)
                .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }.cornerRadius(10)
                .foregroundColor(.white)
                .symbolVariant(.fill)
        }
      
        .background(.yellow)
    }
}

struct WelcomeViewWeather_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeViewWeather()
    }
}
