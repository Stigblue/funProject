import SwiftUI

struct DateTimePickerView: View {
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var showCompanyPrompt = false  // State to toggle the sheet
    @State private var enteredCompanyName = ""    // State to store the entered company name
    let coreDataManager: CoreDataManager
    
    var body: some View {
        VStack {
            DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .padding()
            
            Button(action: {
                showCompanyPrompt = true  // Show the company input prompt when the user taps the button
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Date"), message: Text("Please select a datetime that is not in the future."), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear {
            // Fetch initial date from API or CoreData
            self.selectedDate = selectedDate.fetchValidDateWithMockedHourMinute()
        }
        .sheet(isPresented: $showCompanyPrompt) {
            // Show the sheet for entering company name
            VStack {
                Text("Enter Company Name")
                    .font(.headline)
                    .padding()

                TextField("Company Name", text: $enteredCompanyName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    if selectedDate.isValidDateTime() {
                        // Use the entered company name in the function call
                        coreDataManager.saveCheckInDate(selectedDate, forCompany: enteredCompanyName)
                    } else {
                        showAlert = true
                    }
                    showCompanyPrompt = false  // Dismiss the sheet after submitting
                }) {
                    Text("Submit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
        }
    }
}
