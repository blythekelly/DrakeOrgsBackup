import SwiftUI
import Foundation

//StudentOrg data type
struct StudentOrg: Identifiable, Decodable {
    let id = UUID()
    let orgName: String
    let description: String
    let contactInfo: String
    let interest: String
    
    enum CodingKeys: String, CodingKey {
        case orgName = "org-name"
        case description = "description"
        case contactInfo = "contact-info"
        case interest = "interest"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orgName = try container.decodeIfPresent(String.self, forKey: .orgName) ?? "Unknown"
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? "No description"
        contactInfo = try container.decodeIfPresent(String.self, forKey: .contactInfo) ?? "No contact info"
        interest = try container.decodeIfPresent(String.self, forKey: .interest) ?? "No interest"
    }
}

//list of interest categories
let interests=["Academic", "Cultural", "Governing", "Honors", "Interest", "Media", "Panhellenic", "Professional", "Religious", "Service", "Special Interest", "Sports"]


        
