//
//  ChartDragForPieView.swift
//  Charts Demo 4
//
//  Created by Michael Knych on 5/30/24.
//

import SwiftUI

// beginiing of code to create a drag gesture for the pie chart
// need to figure out some way to convert an x/y CGPoint to a new value for
// the already selected sector

struct ChartDragForPielView: ViewModifier {
  @Binding var chartItem: ChartItem
  @Binding var isDragging: Bool
  
  @State var selectedSales: Double?
  
  var cumulativeSales: [(day: String, range: Range<Double>)] {
    var cumulative = 0.0
    return chartItem.dailySales.map {
      let newCumulative = cumulative + Double($0.sales)
      let result = (day: $0.day, range: cumulative ..< newCumulative)
      cumulative = newCumulative
      return result
    }
  }
  
  var selectedDayData: DailySalesType? {
    if let selectedSales,
       let selectedIndex = cumulativeSales
      .firstIndex(where: { $0.range.contains(selectedSales) }) {
      return chartItem.dailySales[selectedIndex]
    }
    return nil
  }
  
  
  var min: Double {
    chartItem.min
  }
  
  var max: Double {
    chartItem.max
  }
  
  func body(content: Content) -> some View {
    let innerProxyColor: Color = .clear
    content
      .chartAngleSelection(value: $selectedSales)
      
      .chartGesture { chart in
        SpatialTapGesture()
          .onEnded { event in
            let angle = chart.angle(at: event.location)
            chart.selectAngleValue(at: angle)
            //inputSalesAmount = selectedDayData?.sales ?? 0
          }
        
      }
      .chartBackground { chartProxy in
        GeometryReader {geometry in
          //let frame = geometry[chartProxy.plotFrame!]
          Circle()
            .fill(innerProxyColor)
            .contentShape(Circle())
            .gesture(
              DragGesture()
                .onChanged({ value in
                  if chartItem.editMode {
                    isDragging = true
                    let location = value.location
                    // the compiler forced me to add .self
                    let (sales, newDay) = chartProxy.value(at: location, as: (Double, String).self) ?? (-1, "error")
                    
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

