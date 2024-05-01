//
//  SubmitForm.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 2/20/24.
//
import SwiftUI
import Foundation

struct LoginView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var major = ""
    @State private var year = ""
    @State private var admin = false
    @State private var submitted = false // Track form submission
    let years=["Freshman", "Sophomore", "Junior", "Senior", "Graduate School"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Personal Information")) {
                        TextField("Name", text: $name)
                        TextField("Drake Email", text: $email)
                        TextField("Phone Number", text: $phone)
                    }
                    
                    Section(header: Text("Drake Information")) {
                        TextField("Major", text: $major)
                        Picker("Year", selection: $year){
                            ForEach(years, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        Toggle(isOn: $admin) {
                            Text("Admin")
                        }
                        
                    }
                    
                    Button(action: {}) {
                        Text("Submit")
                    }
                }
                .navigationTitle("Create an Account")
                .alert(isPresented: $submitted) {
                    Alert(title: Text("Submitted"), message: nil, dismissButton: .default(Text("OK")))
                }
                
                Spacer() // Add a spacer to push the bottom navigation bar to the bottom
                
                NavigationBar()
            }
        }
    }
}

    

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
