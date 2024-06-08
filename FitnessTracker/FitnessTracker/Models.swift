//
//  Models.swift
//  FitnessTracker
//
//  Created by egemen denizeri on 8.06.2024.
//

import Foundation

// Model for a workout
struct Workout: Identifiable {
    var id = UUID()
    var name: String
    var duration: String
    var date: Date
}

// Model for an exercise
struct Exercise: Identifiable {
    var id = UUID()
    var workoutId: UUID
    var name: String
    var sets: Int
    var repetitions: Int
    var weight: Double
}
