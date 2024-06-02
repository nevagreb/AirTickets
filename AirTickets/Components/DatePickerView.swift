//
//  DatePickerView.swift
//  AirTickets
//
//  Created by Kristina Grebneva on 31.05.2024.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            DatePicker(
                "Choose date",
                selection:  Binding(
                    get: { date },
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
        .accentColor(Colors.blue)
        .environment(\.locale, Locale(identifier: "ru_RU"))
        .environment(\.calendar, Calendar(identifier: .gregorian).withLocale(Locale(identifier: "ru_RU")))
        .padding()
    }
}

extension Calendar {
    func withLocale(_ locale: Locale) -> Calendar {
        var calendar = self
        calendar.locale = locale
        return calendar
    }
}

//#Preview {
//    DatePickerView()
//}
