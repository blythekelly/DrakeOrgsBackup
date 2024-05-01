//
//  FilterSheet.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 3/28/24.
//

import Foundation
import SwiftUI

struct FilterSheetView: View {
    @State private var orgs: [StudentOrg] = [] //State property to hold student orgs
    @Binding var selectedInterests: [String]
    let interests: [String]
    @Binding var filteredStudentOrgs: [StudentOrg]
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        VStack {
            Text("Select Interests")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(interests, id: \.self) { interest in
                        FilterButton(interest: interest, isSelected: selectedInterests.contains(interest)) {
                            if selectedInterests.contains(interest) {
                                selectedInterests.removeAll { $0 == interest }
                            } else {
                                selectedInterests.append(interest)
                            }
                        }
                    }
                }
                .padding()
            }
            
            Button("Apply Filters") {
                // Apply filter logic here
                filteredStudentOrgs = filterOrgs()
                isSheetPresented = false
            }
            .padding()
        }
        .onAppear {
            //fetch org data
            fetchAllOrgs {fetchedOrgs in
                if let fetchedOrgs = fetchedOrgs{
                    orgs=fetchedOrgs
                }
                else{
                    print("fail")
                }
                    
                
            }
        }
    }
    
    
    // Function to filter organizations based on selected interests
    func filterOrgs() -> [StudentOrg] {
        if selectedInterests.isEmpty {
            // If no interests are selected, return all orgs
            return orgs
        } else {
            // Filter orgs based on selected interests
            return orgs.filter { org in
                selectedInterests.contains(org.interest)
            }
        }
    }
    
    struct FilterButton: View {
        let interest: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: {
                action()
            }) {
                Text(interest)
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(isSelected ? Color(UIColor(hex: "#004477")!) : Color(UIColor(hex: "#8e8e93")!))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}
