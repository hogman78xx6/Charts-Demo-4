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
  let innerProxyColor: Color = .black.opacity(0.2)
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
        RuleMarkView(selectedDay: chartItem.selectedDay, salesOnSelectedDay: salesOnSelectedDay, intMode: true)
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
    .chartOverlay { proxy in
      GeometryReader {
        innerProxy in
        Rectangle()
          .fill(innerProxyColor)
          .contentShape(Rectangle())
          .gesture(
            DragGesture()
              .onChanged({ value in
                if chartItem.editMode {
                  isDragging = true
                  let location = value.location
                  // the compiler forced me to add .self
                  let (newDay, sales) = proxy.value(at: location, as: (String, Double).self) ?? ("error", -1)
                  
                  print(newDay)
                  print(sales)
                  
                  // Update selected day
                  chartItem.selectedDay = newDay
                  
                  setSalesOfSelectedDay(dailySales: &chartItem.dailySales, selectedDay: chartItem.selectedDay, sales: sales, min: min, max: max)
                }
              })
              .onEnded({ value in
                  isDragging = false
              })
          )
      }
    }
  }
}

#Preview {
  BarChartVerticalView(chartItem: .constant(.defaultChartItem))
}
