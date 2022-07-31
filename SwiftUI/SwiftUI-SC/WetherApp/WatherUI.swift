//
//  WatherUI.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 01/04/22.
//

import SwiftUI

struct WatherUI: View {
    @StateObject var locationManager = WetherLocationManager()
    var wetherManager = WetherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack {
            if let location = self.locationManager.location {
                if let wether = weather {
                    WetherView(weather: wether)
                } else {
                    LoadingViewWether()
                        .task {
                            do {
                                weather = try await wetherManager.getWeather(lat: location.latitude, long: location.longitude)
                            } catch {
                                print(error)
                            }
                        }
                }
            } else if locationManager.isLoading {
                LoadingViewWether()
            } else {
                WelcomeView().environmentObject(locationManager)
            }
        }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.608, saturation: 0.947, brightness: 0.816)/*@END_MENU_TOKEN@*/)
            .preferredColorScheme(.dark)
    }
}

struct WatherUI_Previews: PreviewProvider {
    static var previews: some View {
        WatherUI()
    }
}
