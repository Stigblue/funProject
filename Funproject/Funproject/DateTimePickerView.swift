import SwiftUI

// Note:
// Single Responsibility Principle: The DateTimePickerView is responsible for the UI and user interaction logic only. All business logic is handled by CoreDataManager, adhering to SRP.
                                                                                    
struct DateTimePickerView: View {
    @State private var selectedDate = Date()
    @State private var showAlert = false
    let coreDataManager: CoreDataManager
    
    var body: some View {
        VStack {
            DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .padding()
            
            Button(action: {
                if isValidDate(selectedDate) {
                    coreDataManager.saveCheckInDate(selectedDate)
                } else {
                    showAlert = true
                }
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Date"), message: Text("Please select a date that is not in the future."), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear {
            // Fetch initial date from API or CoreData
            self.selectedDate = coreDataManager.fetchInitialDate()
        }
    }
    
    func isValidDate(_ date: Date) -> Bool {
        return date <= Date() // Ensure the date is not in the future
    }
}
