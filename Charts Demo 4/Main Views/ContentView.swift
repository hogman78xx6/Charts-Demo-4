//
//  ContentView.swift
//  Charfts Demo 4
//
//  Created by Michael Knych on 5/20/24.
//

import SwiftUI
import Charts

enum ChartType {
  case bar, line, area, pie
}

struct ContentView: View {
  @Binding var chartItem: ChartItem
  
  let xAxisMarkPosition: AxisMarkPosition = .bottom
  let yAxisMarkPosition: AxisMarkPosition = .leading
  
  var body: some View {
    // ------- The chart ---------------------
    if chartItem.isVerticalChart {
      switch(chartItem.chartType) {
      case .bar:
        BarChartVerticalView(chartItem: $chartItem)
      case .line, .area:
        LineAreaChartVerticalView(chartItem: $chartItem)
      case .pie:
        PieChartView(chartItem: $chartItem)
      }
    } else {
      switch(chartItem.chartType) {
      case .bar:
        BarChartHorizontalView(chartItem: $chartItem)
      case .line, .area:
        LineAreaChartHorizontalView(chartItem: $chartItem)
      case .pie:
        PieChartView(chartItem: $chartItem)
      }
    }
  }
}

#Preview(traits: .landscapeRight) {
  ContentView(chartItem: .constant(.defaultChartItem))
}



