//
//  LineAreaChartVerticalView.swift
//  Charts Demo 3
//
//  Created by Michael Knych on 5/20/24.
//

import SwiftUI
import Charts

struct LineAreaChartVerticalView: View {
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
      ForEach(chartItem.dailySales) { item in
        if chartItem.chartType == .area {
          AreaMark(x: .value("Day", item.day),
                   y: .value("Sales", item.sales))
          .foregroundStyle(chartItem
            .lineAreaColor.opacity(0.3)
          )
        }
        
        LineMark(x: .value("Day", item.day),
                 y: .value("Sales", item.sales))
        .foregroundStyle(chartItem.lineAreaColor)
        .symbol() {
          Annotate_Line_Area_Graph(chartItem: chartItem)
        }
      }
      
      if isDragging {
        RuleMarkForVerticalView(chartItem: chartItem, salesOnSelectedDay: salesOnSelectedDay)
      }
    }
    .chartYScale(domain: min...max)
    // chart item dragging logic
    .modifier(ChartDragForVerticalView(chartItem: $chartItem, isDragging: $isDragging))
  }
}

#Preview {
    LineAreaChartVerticalView(chartItem: .constant(.defaultChartItem))
}
