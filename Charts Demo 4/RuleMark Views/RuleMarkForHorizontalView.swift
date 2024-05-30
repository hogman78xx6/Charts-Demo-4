//
//  RuleMarkForHorizontalView.swift
//  Charts Demo 4
//
//  Created by Michael Knych on 5/24/24.
//

import SwiftUI
import Charts

struct RuleMarkForHorizontalView: ChartContent {
  let chartItem: ChartItem
  let salesOnSelectedDay: Double
  
  var selectedDay: String {
    chartItem.selectedDay
  }
   
  var intMode: Bool {
    chartItem.intMode
  }
  
  let lineColor = Color.red
  
  // 0 means 0 decimal places and 1 means 1 deciaml place
  var precesion: Int {
    intMode ? 0 : 1
  }
  
  var specifier: String {
    "%.\(precesion)f"
  }
  
    var body: some ChartContent {
      RuleMark(x: .value("Sales", salesOnSelectedDay))
        .foregroundStyle(lineColor)
        .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
        .annotation(position: .topTrailing, spacing: 0) {
          Text("\(salesOnSelectedDay, specifier: specifier)")
            .font(.subheadline).bold()
        }
    }
}


