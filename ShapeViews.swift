//
//  ShapeViews.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 2/17/24.
//

import SwiftUI


extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


struct OrgButtonView: View {
    let org: StudentOrg
    @State private var isButtonPressed: Bool = false
    
    var body: some View {
        Button(action: {
            self.isButtonPressed = true
        }) {
            VStack {
                Text(org.orgName)
                    .font(.system(size: 24, weight: .bold))
                    .font(.headline)
                    .foregroundColor(.black)
                Text(org.interest)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(UIColor(hex: "#004477")!))
                    )
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 130)
        .background(Color.white)
                .cornerRadius(10)
                //once button is pressed, send label data to club page
                .sheet(isPresented: $isButtonPressed) {
                    DisplayTextView(org: org)
                }
    }
}


