//
//  DatePickerView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 31.05.2024.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date?
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            DatePicker(
                "Choose date",
                selection:  Binding(
                    get: { date ?? Date() },
                    set: { newValue in date = newValue }
                ),
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            .onTapGesture(count: 2) {
                dismiss()
            }
            
            Button("Готово") {
                dismiss()
            }
        }
        .accentColor(.white)
    }
}

//#Preview {
//    DatePickerView()
//}
