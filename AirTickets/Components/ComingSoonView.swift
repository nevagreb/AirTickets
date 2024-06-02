//
//  ComingSoonView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 29.05.2024.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gear")
                .imageModifier()
            Text("Раздел в разработке")
                .font(Font.DesignSystem.title1)
        }
        .foregroundColor(Colors.grey6)
    }
}

#Preview {
    ComingSoonView()
}
