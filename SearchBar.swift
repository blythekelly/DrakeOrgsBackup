//
//  SearchBar.swift
//  DrakeOrgs
//
//  Created by Blythe Kelly on 3/18/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(false)
        }
        .padding(.horizontal)
    }
}

