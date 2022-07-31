//
//  WeatherRootView.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 29/05/22.
//

import SwiftUI

struct WeatherRootView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherManager = WeatherManager()
   
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weatherManager.weather {
                    Text(weather.name)
                } else {
                    LoadingViewWeather(tint: .red)
                        .task { // Can only all here
                        let _ = await weatherManager.getWeather(lat: location.latitude, long: location.longitude)
                    }
                }
            } else if locationManager.isloading {
                LoadingViewWeather(tint: .white)
            } else {
                WelcomeViewWeather().environmentObject(locationManager) // Yellow is coming from here
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.661, saturation: 0.709, brightness: 0.901)/*@END_MENU_TOKEN@*/) // blue
            .preferredColorScheme(.dark)
    }
}

struct WeatherRootView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRootView()
    }
}
