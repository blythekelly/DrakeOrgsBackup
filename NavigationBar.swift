//
//  NavigationBar.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 4/1/24.
//

import Foundation
import SwiftUI

struct NavigationBar: View {
    enum NavigationDestination: String, Identifiable {
        case contentView = "ContentView"
        case clubsView = "ClubsView"
        case submitFormView = "SubmitFormView"
        
        var id: String { self.rawValue }
    }
    
    @State private var selectedView: NavigationDestination?
    
    var body: some View {
        // Bottom Navigation Bar for directing between views
        HStack(spacing: 55) {
            Button(action: {
                selectedView = .contentView
            }) {
                VStack {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 20))
                    Text("Explore")
                        .font(.system(size: 13))
                }
            }
            
            Button(action: {
                selectedView = .clubsView
            }) {
                VStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 20))
                    Text("Org List")
                        .font(.system(size: 13))
                }
            }
            
            Button(action: {
                selectedView = .submitFormView
            }) {
                VStack {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 20))
                    Text("Submit Event")
                        .font(.system(size: 13))
                }
            }
        }
        .foregroundColor(Color(UIColor(hex: "#004477")!))
        .padding(.horizontal)
        .fullScreenCover(item: $selectedView) { view in
            // Use a switch statement to navigate to the selected view
            switch view {
            case .contentView:
                ContentView()
            case .clubsView:
                ClubsView()
            case .submitFormView:
                SubmitFormView()
            }
        }
    }
}
