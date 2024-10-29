import SwiftUI

struct DateTimePickerView: View {
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var showCompanyPrompt = false
    @State private var enteredCompanyName = ""
    let employeeService = EmployeeService()
    
    var body: some View {
        content
            .onAppear {
                self.selectedDate = selectedDate.fetchValidDateWithMockedHourMinute()
            }
            .sheet(isPresented: $showCompanyPrompt) {
                sheetView
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Date"), message: Text("Please select a datetime that is not in the future."), dismissButton: .default(Text("OK")))
            }
    }
    
    var content: some View {
        VStack {
            DatePicker(
              "Select Date and Time",
              selection: $selectedDate,
              in: ...Date(),
              displayedComponents: [.date, .hourAndMinute]
            )
                .padding()
            
            Button(action: {
                showCompanyPrompt = true
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }
}

private extension DateTimePickerView {
    var sheetView: some View {
        VStack {
            Text("Enter Company Name")
                .font(.headline)
                .padding()
            
            TextField("Company Name", text: $enteredCompanyName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                if selectedDate.isValidDateTime() {
                    let employeeService = EmployeeService()
                    employeeService.saveCheckInDate(selectedDate, forCompany: enteredCompanyName)
                    
                } else {
                    showAlert = true
                }
                showCompanyPrompt = false
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding()
        }
        .padding()
    }
}


