//
//  ChartDragForHorizontalView.swift
//  Charts Demo 4
//
//  Created by Michael Knych on 5/26/24.
//

import SwiftUI

struct ChartDragForHorizontalView: ViewModifier {
  @Binding var chartItem: ChartItem
  @Binding var isDragging: Bool
  var min: Double {
    chartItem.min
  }
  
  var max: Double {
    chartItem.max
  }
  
  func body(content: Content) -> some View {
    let innerProxyColor: Color = .clear
    content
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
                    let (sales, newDay) = proxy.value(at: location, as: (Double, String).self) ?? (-1, "error")
                    
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


