//
//  ContentView.swift
//  FitnessTracker
//
//  Created by egemen denizeri on 8.06.2024.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Fitness Tracker")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: AddWorkoutView()) {
                    Text("Add Workout")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
