//
//  ArticleEntry.swift
//  SimpleNews
//
//  Created by Personal on 12/10/2023.
//

import Foundation
import WidgetKit

struct ArticleEntry: TimelineEntry {
    enum State {
        case articles([ArticleWidgetModel])
        case failure(Error)
    }
    
    let date: Date
    let state: State
    let category: Category
}
