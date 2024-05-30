//
//  ContentView.swift
//  Charfts Demo 4
//
//  Created by Michael Knych on 5/20/24.
//

import SwiftUI
import Charts

enum ChartType {
  case bar, line, area
}

struct ContentView: View {
  @State var chartItem: ChartItem = .defaultChartItem
  
  let xAxisMarkPosition: AxisMarkPosition = .bottom
  let yAxisMarkPosition: AxisMarkPosition = .leading
  
  var body: some View {
    VStack {
      HStack {
        Button(action: {
          withAnimation {
            chartItem.editMode.toggle()
          }
          
        }, label: {
          Image(systemName: chartItem.editMode ? "checkmark" : "square.and.pencil")
        })
        if !chartItem.editMode {
          Spacer()
          Button(action: {
            withAnimation {
              // TODO: Sharing
            }
            
          }, label: {
            Image(systemName: "square.and.arrow.up")
          })
        }
      }
      
      HStack {
        // ----- Left Chart Buttons ---------------------
        if chartItem.editMode  {
          LeftChartButtonsView(chartItem: $chartItem)
        }
        
        // ---   The Title and Chart --------------------
        VStack(alignment: chartItem.titleAligment) {
          Text(chartItem.title)
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.vertical)
          // ------- The chart ---------------------
          if chartItem.isVerticalChart {
            switch(chartItem.chartType) {
            case .bar:
              BarChartVerticalView(chartItem: $chartItem)
            case .line, .area:
              LineAreaChartVerticalView(chartItem: $chartItem)
            }
          } else {
            switch(chartItem.chartType) {
            case .bar:
              BarChartHorizontalView(chartItem: $chartItem)
            case .line, .area:
              LineAreaChartHorizontalView(chartItem: $chartItem)
            }
          }
        }
        
        // ----- Right Chart Button ------------------------
        if chartItem.editMode  {
          RightChartButtonsView(chartItem: $chartItem)
        }
        
      }
      
    }  // end of vstack
    .padding()
  }
}

#Preview(traits: .landscapeRight) {
  ContentView()
}



