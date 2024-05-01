//
//  Events.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 2/21/24.
//

import Foundation
import SwiftUI

//Event data structure
struct Event: Identifiable, Decodable {
    let id = UUID()
    let date: String
    let contactName: String
    let location: String
    let contactEmail: String
    let orgName: String
    let description: String
    let title: String
    let time: String
    
    
    //coding keys that handle different keys on the API
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case contactName = "contact-name"
        case location = "location"
        case contactEmail = "contact-email"
        case orgName = "org-name"
        case description = "description"
        case title = "title"
        case time = "time"
    }
    
    //having the initializer handle missing values
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? "No date"
        contactName = try container.decodeIfPresent(String.self, forKey: .contactName) ?? "No contact name"
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? "No location"
        contactEmail = try container.decodeIfPresent(String.self, forKey: .contactEmail) ?? "No contact email"
        orgName = try container.decodeIfPresent(String.self, forKey: .orgName) ?? "No student organization"
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? "No description"
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "No title"
        time = try container.decodeIfPresent(String.self, forKey: .time) ?? "No time"
    }
}




//defining the card that will display each event
struct UpcomingEvents: View {
    
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.headline)
            Text(event.date)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(event.time)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(event.location)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(event.contactName)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(event.contactEmail)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 200, height: 150)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

//function to fetch all events from the API
func fetchEvents(completion: @escaping ([Event]?) -> Void) {
    // Define the API URL
    let apiUrlString = "https://d4kfv1hyq7.execute-api.us-east-1.amazonaws.com/DrakeOrgs-API/events/get/all"
    
    guard let apiUrl = URL(string: apiUrlString) else {
        // Handle URL creation failure
        print("Invalid API URL")
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: apiUrl) { data, response, error in
        if let error = error {
            // Handle network or data task error
            print("Error fetching data: \(error)")
            completion(nil)
            return
        }
        
        guard let responseData = data else {
            // Handle empty response data
            print("No data received")
            completion(nil)
            return
        }


        do {
            // Parse JSON data into an array of Event objects
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let events = try decoder.decode([Event].self, from: responseData)
            completion(events)
        } catch {
            // Handle JSON decoding error
            print("Error parsing JSON: \(error)")
            completion(nil)
        }
    }.resume()
}




