//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by 박현진 on 8/8/25.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetControl()
        MyWidgetLiveActivity()
    }
}
