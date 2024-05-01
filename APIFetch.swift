//
//  APIFetch.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 3/20/24.
//

import Foundation
import SwiftUI



func fetchAllOrgs(completion: @escaping ([StudentOrg]?) -> Void) {
    let urlString = "https://d4kfv1hyq7.execute-api.us-east-1.amazonaws.com/DrakeOrgs-API/get/all"
    guard let apiUrl = URL(string: urlString) else {
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
            // Parse JSON data into an array of Org objects
            let decoder = JSONDecoder()
            let orgs = try decoder.decode([StudentOrg].self, from: responseData)
            completion(orgs)
        } catch {
            // Handle JSON decoding error
            print("Error parsing JSON: \(error)")
            completion(nil)
        }
    }.resume()
}
