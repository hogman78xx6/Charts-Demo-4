//
//  RightChartButtonsView.swift
//  Charfts Demo 4
//
//  Created by Michael Knych on 5/21/24.
//

import SwiftUI

struct RightChartButtonsView: View {
  @Binding var chartItem: ChartItem
  
  var body: some View {
    VStack(spacing: 50) {
      Button(action: {
        withAnimation {
          chartItem.isVerticalChart.toggle()
        }
      }, label: {
        Image(systemName: "chart.bar.fill")
          .rotationEffect(.degrees(chartItem.isVerticalChart ? 90 : 0))
          .foregroundStyle(.black.opacity(0.7))
      })
      
      TitleAlignmentButton(titleAligment: $chartItem.titleAligment)
    }
    .padding()
  }
}

#Preview(traits: .landscapeRight) {
  HStack {
    Spacer()
    RightChartButtonsView(chartItem: .constant(.defaultChartItem))
    
  }
}
