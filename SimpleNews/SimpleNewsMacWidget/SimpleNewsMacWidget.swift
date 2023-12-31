//
//  SimpleNewsMacWidget.swift
//  SimpleNewsMacWidget
//
//  Created by Personal on 12/10/2023.
//

import WidgetKit
import SwiftUI
import Intents

@main
struct SimpleNewsMacWidget: Widget {
    let kind: String = "SimpleNewsMacWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SelectCategoryIntent.self, provider: ArticleProvider()) { entry in
            ArticleEntryWidgetView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
