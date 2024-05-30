//
//  ChartButtonsView.swift
//  Charfts Demo 4
//
//  Created by Michael Knych on 5/21/24.
//

import SwiftUI

struct LeftChartButtonsView: View {
  
  @Binding var chartItem: ChartItem
  
    var body: some View {
      VStack {
        Button(action: {
          withAnimation {
            chartItem.chartType = .bar
          }
        }, label: {
          Text("BAR")
        })
        Spacer()
        Button(action: {
          withAnimation {
            chartItem.chartType = .line
          }
        }, label: {
          Text("LINE")
        })
        Spacer()
        Button(action: {
          withAnimation {
            chartItem.chartType = .area
          }
        }, label: {
          Text("AREA")
        })
        Spacer()
        Button(action: {
          withAnimation {
            chartItem.chartType = .pie
          }
        }, label: {
          Text("PIE")
        })
        Spacer()
        ColorfulButtonView(chartItem: $chartItem, dim: 30, offset: 10) {}
      }
      .padding()
    }
}

#Preview(traits: .landscapeRight) {
  HStack {
    LeftChartButtonsView(chartItem: .constant(.defaultChartItem))
    Spacer()
  }
}
