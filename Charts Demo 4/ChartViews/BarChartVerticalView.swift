//
//  BarChartVerticalView.swift
//  Charts Demo 3
//
//  Created by Michael Knych on 5/20/24.
//

import SwiftUI
import Charts 

struct BarChartVerticalView: View {
  @Binding var chartItem: ChartItem

  var min: Double {
    chartItem.min
  }
  
  var max: Double {
    chartItem.max
  }
  
  
  // Dragging related properties
  @State var isDragging: Bool = false
  
  var salesOnSelectedDay: Double {
    getSalesOfSelectedDay(dailySales: chartItem.dailySales,
                          selectedDay: chartItem.selectedDay
    )
  }
  
  
  var body: some View {
    Chart {
      // this will have the RuleMArk show behind the chart
      // (i.e., the chart will be placed on top of the RuleMArk
      if isDragging {
        RuleMarkForVerticalView(chartItem: chartItem, salesOnSelectedDay: salesOnSelectedDay)
      }
      
      ForEach(chartItem.dailySales) { item in
        BarMark(x: .value("Day", item.day),
                 y: .value("Sales", item.sales))
        .foregroundStyle(by: .value("Day", item.day))
        .annotation(position: .top) {
          Image(systemName: "circle")
            .fontWeight(.bold)
            .foregroundStyle(.red)
            .opacity(chartItem.editMode ? 0.8 : 0.0)
        }
      }
      // doing the RuelMark here will place it hehind the chart
//      if isDragging {
//        RuleMarkView(selectedDay: selectedDay, salesOnSelectedDay: salesOnSelectedDay, intMode: true)
//      }
    }
    .chartForegroundStyleScale(range: chartItem.barColors)
    .chartYScale(domain: min...max)
    // chart item dragging logic
    .modifier(ChartDragForVerticalView(chartItem: $chartItem, isDragging: $isDragging))
  }
}

#Preview {
  BarChartVerticalView(chartItem: .constant(.defaultChartItem))
}
