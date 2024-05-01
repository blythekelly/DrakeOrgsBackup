//
//  SubmitForm.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 2/20/24.
//
import SwiftUI
import Foundation

struct SubmitFormView: View {
    @State private var organizationName = ""
    @State private var contactName = ""
    @State private var contactEmail = ""
    @State private var eventDescription = ""
    @State private var eventLocation = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var submitted = false // Track form submission

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Organization Information")) {
                        TextField("Organization Name", text: $organizationName)
                        TextField("Contact Name", text: $contactName)
                        TextField("Contact Email", text: $contactEmail)
                    }

                    Section(header: Text("Event Information")) {
                        TextField("Event Name", text: $eventDescription)
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                        DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                        TextField("Event Location", text: $eventLocation)
                    }

                    Button(action: submitForm) {
                        Text("Submit")
                    }
                }
                .navigationTitle("Submit Information")
                .alert(isPresented: $submitted) {
                    Alert(title: Text("Submitted"), message: nil, dismissButton: .default(Text("OK")))
                }
                
                Spacer() // Add a spacer to push the bottom navigation bar to the bottom
                
                NavigationBar()
            }
        }
    }

    //function to submit the form
    func submitForm() {
        let apiUrl = URL(string: "https://d4kfv1hyq7.execute-api.us-east-1.amazonaws.com/DrakeOrgs-API/events/put-event")!

        // Create a dictionary with the event data
        let eventData: [String: Any] = [
            "data": [
                "org-name": organizationName,
                "contact-name": contactName,
                "contact-email": contactEmail,
                "title": eventDescription,
                "description": eventDescription,
                "location": eventLocation,
                "date": formatDate(date),
                "time": formatTime(time)
            ]
        ]

        // Convert the data to JSON format
        guard let jsonData = try? JSONSerialization.data(withJSONObject: eventData) else {
            print("Error converting data to JSON")
            return
        }

        // Create the URLRequest for the PUT request
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Create a URLSession task to send the request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Event submitted successfully.")
                    // Optionally update UI or perform any post-submission actions
                    DispatchQueue.main.async {
                        submitted = true // Update the submitted state to show the alert
                    }
                } else {
                    print("Failed to submit event. Status code: \(response.statusCode)")
                    // Handle other status codes if needed
                }
            }
        }.resume()
    }
    //changing the date into the API formatting
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yy"
        return formatter.string(from: date)
    }
    //changing the time into the API formatting
    func formatTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time)
    }
}

struct SubmitFormView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitFormView()
    }
}
