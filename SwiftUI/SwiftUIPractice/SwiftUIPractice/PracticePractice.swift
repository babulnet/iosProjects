//
//  PracticePractice.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 25/06/22.
//

import SwiftUI
struct Player {
    var time: Double = Date().timeIntervalSince1970
}
class Presenter: ObservableObject {
     @Published var player: Player = Player()
    init() {
        changeCurrentTime()
    }
    
    private func changeCurrentTime() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.player.time = Date().timeIntervalSince1970
        }
    }
    
}

struct PracticePractice: View {
    @State var isPlaying = false
    @State var currrentPlayeTime: Double = 0.0
    @StateObject var presenter = Presenter()

    var body: some View {
        VStack {
            Text("A.R Rahman").font(.title)
                .foregroundColor(isPlaying ? .gray:.black)
            Text("Ennavale")
                .foregroundColor(isPlaying ? .gray:.black)
            PlayButton(isPlaying: $isPlaying)
            Text("\(currrentPlayeTime)")
            Button {
                self.presenter.player.time = 0.0
            } label: {
                Text("TAP TAP")
            }

        }.onReceive(presenter.$player) { p in
            self.currrentPlayeTime = p.time
        }
    }
}

struct PlayButton: View {
   @Binding var isPlaying: Bool
   
    var body: some View {
        Button {
            isPlaying.toggle()
        } label: {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
        }
    }
 
}

struct PracticePractice_Previews: PreviewProvider {
    static var previews: some View {
        PracticePractice()
    }
}
