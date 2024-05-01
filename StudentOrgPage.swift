import SwiftUI

struct DisplayTextView: View {
    let org: StudentOrg
    @State private var events: [Event] = [] // State property to hold events
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Navigation bar with back button
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss() // Dismiss the current view
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                .padding(.leading, 10)
                
                Spacer()
            }
            
            // Title
            Text(org.orgName)
                .font(.title)
                .fontWeight(.bold)
            
            Divider()
            
            // Organization description
            VStack {
                Text("Description:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(org.description)
                    .padding()
                    .font(.body)
            }
            
            Divider()
            
            // Contact information
            VStack {
                Text("Contact:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(org.contactInfo)
                    .font(.body)
            }
            .padding(.horizontal)
            Divider()
            
            // Upcoming events
            VStack {
                Text("Upcoming Events")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    if events.isEmpty {
                        Text("No upcoming events")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        HStack(spacing: 15) {
                            ForEach(events.filter { $0.orgName == org.orgName }) { event in
                                UpcomingEvents(event: event) // Pass the actual Event instance to EventCard
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }

            .onAppear{
                fetchEvents { fetchedEvents in
                    if let fetchedEvents = fetchedEvents {
                        // Update the events state property with fetched events
                        events=fetchedEvents
                        
                    } else {
                        print("Failed to fetch events data")
                    }
                    
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
    }
    
    
    struct EventCard: View {
        var event: Event
        
        var body: some View {
            VStack {
                Text(event.title) // Use event properties
                    .font(.body)
                    .fontWeight(.medium)
                    .padding()
                    .frame(width: 150, height: 100)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
        }
    }
}
