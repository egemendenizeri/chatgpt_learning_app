import SwiftUI

struct AddWorkoutView: View {
    @State private var workoutName: String = ""
    @State private var duration: String = ""
    @State private var workoutDate: Date = Date()
    @State private var exercises: [Exercise] = []

    @State private var newExerciseName: String = ""
    @State private var newExerciseSets: String = ""
    @State private var newExerciseRepetitions: String = ""
    @State private var newExerciseWeight: String = ""

    // Focus state to manage keyboard
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case workoutName, duration, newExerciseName, newExerciseSets, newExerciseRepetitions, newExerciseWeight
    }

    var body: some View {
        NavigationView {
            Form {
                // Workout Details Section
                Section(header: Text("Workout Details")) {
                    TextField("Workout Name", text: $workoutName)
                        .focused($focusedField, equals: .workoutName)
                    TextField("Duration (minutes)", text: $duration)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .duration)
                    DatePicker("Date", selection: $workoutDate, displayedComponents: .date)
                }

                // Add Exercise Section
                Section(header: Text("Add Exercise")) {
                    TextField("Exercise Name", text: $newExerciseName)
                        .focused($focusedField, equals: .newExerciseName)
                    TextField("Sets", text: $newExerciseSets)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .newExerciseSets)
                    TextField("Repetitions", text: $newExerciseRepetitions)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .newExerciseRepetitions)
                    TextField("Weight (kg)", text: $newExerciseWeight)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .newExerciseWeight)
                    Button(action: {
                        addExercise()
                        dismissKeyboard()
                    }) {
                        Text("Add Exercise")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                // Exercises List Section
                Section(header: Text("Exercises")) {
                    List {
                        ForEach(exercises) { exercise in
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                    .font(.headline)
                                Text("Sets: \(exercise.sets), Reps: \(exercise.repetitions), Weight: \(String(format: "%.1f", exercise.weight)) kg")
                            }
                        }
                        .onDelete(perform: deleteExercise)
                    }
                }

                // Save Workout Button
                Button(action: {
                    saveWorkout()
                    dismissKeyboard()
                }) {
                    Text("Save Workout")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Add Workout")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        dismissKeyboard()
                    }
                }
            }
        }
    }

    // Function to add an exercise to the workout
    func addExercise() {
        guard let sets = Int(newExerciseSets),
              let repetitions = Int(newExerciseRepetitions),
              let weight = Double(newExerciseWeight) else { return }

        let newExercise = Exercise(workoutId: UUID(), name: newExerciseName, sets: sets, repetitions: repetitions, weight: weight)
        exercises.append(newExercise)

        // Clear the input fields
        newExerciseName = ""
        newExerciseSets = ""
        newExerciseRepetitions = ""
        newExerciseWeight = ""
    }

    // Function to delete an exercise from the list
    func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    // Function to save the workout details
    func saveWorkout() {
        // Save workout and exercises to the database (to be implemented)
        print("Workout Name: \(workoutName)")
        print("Duration: \(duration) minutes")
        print("Date: \(workoutDate)")
        for exercise in exercises {
            print("Exercise: \(exercise.name), Sets: \(exercise.sets), Reps: \(exercise.repetitions), Weight: \(String(format: "%.1f", exercise.weight)) kg")
        }
    }

    // Function to dismiss the keyboard
    private func dismissKeyboard() {
        focusedField = nil
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}

