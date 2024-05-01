//
//  ClubsAndEvents.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 2/14/24.
//

import SwiftUI

struct ClubsView: View {
    @State private var events: [Event] = [] // State property to hold events
    @State private var orgs: [StudentOrg] = [] //State property to hold student orgs
    
    var body: some View {
        NavigationView {
            // Vertical stack of app content
            VStack {
                // Title of the page
                Text("DrakeOrgs")
                    .font(.system(size: 34))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(UIColor(hex: "#004477")!))
                
                // ScrollView for displaying events
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(events) { event in
                            UpcomingEvents(event: event)
                        }
                    }
                    .padding()
                }
                
                // Vertical stack of rectangle buttons for club list
                VStack {
                    Divider()
                    ScrollView {
                            ForEach(orgs, id: \.id) { org in
                                OrgButtonView(org: org)
                            }
                            .padding()
                        }
                        .frame(height: 430)
                        .background(Color(UIColor(hex: "#EAEAEA")!))
                        Divider()
                        Spacer()
                    }
                    NavigationBar()
            }
            .onAppear {
                // Fetch events data when the view appears
                fetchEvents { fetchedEvents in
                    if let fetchedEvents = fetchedEvents {
                        // Update the events state property with fetched events
                        events=fetchedEvents
                        
                    } else {
                        print("Failed to fetch events data")
                    }
                
                }
                
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
    }
}

struct ClubsandEventsView_Previews: PreviewProvider {
    static var previews: some View {
        ClubsView()
    }
}
