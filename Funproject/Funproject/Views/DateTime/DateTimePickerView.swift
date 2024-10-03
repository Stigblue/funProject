import SwiftUI

struct DateTimePickerView: View {
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var showCompanyPrompt = false
    @State private var enteredCompanyName = ""
    let coreDataManager: CoreDataManager
    
    var body: some View {
        VStack {
            DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .padding()
            
            Button(action: {
                showCompanyPrompt = true
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
            self.selectedDate = selectedDate.fetchValidDateWithMockedHourMinute()
        }
        .sheet(isPresented: $showCompanyPrompt) {
            VStack {
                Text("Enter Company Name")
                    .font(.headline)
                    .padding()

                TextField("Company Name", text: $enteredCompanyName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    if selectedDate.isValidDateTime() {
                        coreDataManager.saveCheckInDate(selectedDate, forCompany: enteredCompanyName)
                    } else {
                        showAlert = true
                    }
                    showCompanyPrompt = false
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
