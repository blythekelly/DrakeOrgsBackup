//
//  ContentView.swift
//  Shared
//
//  Created by Blythe Kelly on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var orgs: [StudentOrg] = [] // State property to hold student orgs
    @State private var filteredStudentOrgs: [StudentOrg] = [] // Initialize with an empty array
    @State private var isFilterSheetPresented = false
    @State private var selectedInterests: [String] = [] //list of interests that will eventually filter results
    @State private var dataLoaded = false // Track if data has been loaded
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("DrakeOrgs")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#004477")!))
                
                HStack {
                    // Search Bar
                    SearchBar(text: $searchText, placeholder: "Search clubs")
                    
                    // Filter Button
                    Button(action: {
                        isFilterSheetPresented.toggle()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 20))
                            .foregroundColor(Color(UIColor(hex: "#8e8e93")!))
                    }
                    .padding(.trailing)
                }
                
                // Vertical stack of buttons for club list
                VStack {
                    Divider()
                    ScrollView {
                        ForEach(filteredStudentOrgs, id: \.id) { org in
                            OrgButtonView(org: org)
                        }
                        .padding()
                    }
                    .frame(height: 565)
                    .background(Color(UIColor(hex: "#EAEAEA")!))
                    Divider()
                    Spacer()
                }
                NavigationBar()
            }
            //when search text changes, display filtered orgs
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    filteredStudentOrgs = orgs
                } else {
                    filteredStudentOrgs = orgs.filter { $0.orgName.localizedCaseInsensitiveContains(newValue) }
                }
            }
            //update arrays with selected interests
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterSheetView(selectedInterests: $selectedInterests, interests: interests, filteredStudentOrgs: $filteredStudentOrgs, isSheetPresented: $isFilterSheetPresented)
            }
        }
        .onAppear {
                        if !dataLoaded {
                            // Fetch orgs data only if dataLoaded is false
                            fetchAllOrgs { fetchedOrgs in
                                if let fetchedOrgs = fetchedOrgs {
                                    orgs = fetchedOrgs
                                    filteredStudentOrgs = fetchedOrgs
                                    dataLoaded = true // Set dataLoaded to true after fetching data
                                } else {
                                    print("Failed to fetch data")
                                }
                            }
                        }
                    }
        
    }
}

    
    
    
// Preview
#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewInterfaceOrientation(.portrait)
            
        }
    }
#endif
    

