//
//  ContentView.swift
//  FitnessCompanion Watch App
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

extension Color {
    static let lockColour = Color("lockColour")
    static let lockColourBackground = Color("lockColourBackground")
    
    static let newColour = Color("newColour")
    static let newColourBackground = Color("newColourBackground")
    
    static let endColour = Color("endColour")
    static let endColourBackground = Color("endColourBackground")
    
    static let pauseColour = Color("pauseColour")
    static let pauseColourBackground = Color("pauseColourBackground")
}

struct Exercise {
    var name: String
    var image: String
}

struct MainView: View {
    
    @State private var counter = 0
    @State private var timerString = "00:00:00"
    @State private var bpm = 120
    @State private var calories = 110
    @State private var activity = "Running"
    
    @State private var isTimerRunning = false
    @State private var isTimerPaused = false
    
    @State private var tabSelection = "viewer"
    
    func Lock() {
        print("Lock button is pressed")
    }
    
    func New() {
        print("New button is pressed")
    }
    
    func End() {
        print("End button is pressed")
    }
    
    func Pause() {
        print("Pause button is pressed")
    }
    
    func startTimer() {
        stopTimer()
        isTimerRunning = true
    }
    
    func pauseTimer() {
        isTimerRunning = false
        isTimerPaused = true
        tabSelection = "viewer"
    }
    
    func stopTimer() {
        isTimerRunning = false
        isTimerPaused = false
        counter = 0
        timerString = "00:00:00"
        tabSelection = "viewer"
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let exercises = [
        Exercise(name: "Running", image: "figure.run"),
        Exercise(name: "Cycling", image: "figure.outdoor.cycle"),
        Exercise(name: "Swimming", image: "figure.pool.swim")
        // Add more exercises here
    ]
    
    var body: some View {
        TabView(selection: $tabSelection) {
            // Timer tab
            VStack(alignment: .leading) {
                Text(timerString)
                    .font(.title2)
                    .foregroundColor(.yellow)
                    .padding(.bottom)
                    .onReceive(timer) { time in
                        if isTimerRunning && !isTimerPaused {
                            counter += 1
                            let hours = counter / 3600
                            let minutes = (counter % 3600) / 60
                            let seconds = counter % 3600 % 60
                            timerString = String(format: "%02d", hours) + ":" + String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
                        }
                    }
                Text(String(bpm) + "BPM")
                Text(String(calories) + " Calories")
                Text(activity)
            }
            .padding()
            .tag("viewer")
            
            // Exercise tab
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(exercises, id: \.name) { exercise in
                        HStack(alignment: .center, spacing: 10) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .foregroundColor(.newColourBackground)
                                    .frame(width: 70, height: 64)
                                Image(systemName: exercise.image)
                                    .resizable()
                                    .foregroundColor(.newColour)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22)
                            }
                            Text(exercise.name)
                        }.onTapGesture {
                            activity = exercise.name
                            tabSelection = "viewer"
                        }
                    }
                }
                .padding()
            }
            .tag("types")
            
            // Buttons tab
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .foregroundColor(.lockColourBackground)
                                .frame(width: 70, height: 64)
                            Image(systemName: "drop.fill")
                                .resizable()
                                .foregroundColor(.lockColour)
                                .aspectRatio(0.7, contentMode: .fit)
                                .frame(width: 22)
                        }
                        
                        Text("Lock")
                    }.onTapGesture {
                        Lock()
                    }
                    
                    VStack {
                        Button(action: startTimer) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .foregroundColor(.newColourBackground)
                                    .frame(width: 70, height: 64)
                                Image(systemName: "plus")
                                    .resizable()
                                    .foregroundColor(.newColour)
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .frame(width: 22)
                            }
                        }.buttonStyle(PlainButtonStyle())
                        Text("New")
                    }.onTapGesture {
                        New()
                    }
                }
                
                HStack(spacing: 10) {
                    VStack {
                        Button(action: stopTimer) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .foregroundColor(.endColourBackground)
                                    .frame(width: 70, height: 64)
                                Image(systemName: "xmark")
                                    .resizable()
                                    .foregroundColor(.endColour)
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .frame(width: 22)
                            }
                        }.buttonStyle(PlainButtonStyle())
                        
                        Text("End")
                    }.onTapGesture {
                        End()
                    }
                    
                    VStack {
                        Button(action: isTimerRunning ? pauseTimer : startTimer) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .foregroundColor(.pauseColourBackground)
                                    .frame(width: 70, height: 64)
                                Image(systemName: isTimerRunning ? "pause" : "play.fill")
                                    .resizable()
                                    .foregroundColor(.pauseColour)
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .frame(width: 22)
                            }
                        }.buttonStyle(PlainButtonStyle())
                        
                        Text("Pause")
                    }.onTapGesture {
                        Pause()
                    }
                }
                
            }
            .padding(.top, 20)
            .tag("controls")
        }
        .animation(.easeInOut)
        .transition(.slide)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
