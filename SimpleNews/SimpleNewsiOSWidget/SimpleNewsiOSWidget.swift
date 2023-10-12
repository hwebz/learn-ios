//
//  SimpleNewsiOSWidget.swift
//  SimpleNewsiOSWidget
//
//  Created by Personal on 12/10/2023.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct SimpleNewsiOSWidget: Widget {
    let kind: String = "SimpleNewsiOSWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectCategoryIntent.self, provider: ArticleProvider()) { entry in
            Text("Placeholder")
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
