//
//  PieChartView.swift
//  Charts Demo 4
//
//  Created by Michael Knych on 5/27/24.
//

import SwiftUI
import Charts

struct PieChartView: View {
  @Binding var chartItem: ChartItem
  
  // code to covert the selected pie chart angle into chartItem.dailySales item
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
  
  
  @State var inputSalesAmount: Double = 0
  
  var min: Double {
    chartItem.min
  }
  
  var max: Double {
    chartItem.max
  }
  
  var body: some View {
    HStack {
      Chart(chartItem.dailySales) {
        SectorMark(angle: .value("Sales", $0.sales),
                   innerRadius: .ratio(selectedDayData == $0 ? 0.5 : 0.6),
                   outerRadius: .ratio(selectedDayData == $0 ? 1.0 : 0.9),
                   angularInset: 3.0)
        .cornerRadius(5.0)
        .foregroundStyle(by: .value("Day", $0.day))
        .annotation(position: .leading) {
        }
      }
      .chartForegroundStyleScale(domain: chartItem.dailySales.map { $0.day }, range: chartItem.barColors)
      .chartLegend(position: .trailing, alignment: .center)
      .foregroundStyle(Color.red)
      
      // @State variable to save the selected angle raw data created by the
      // .chartGesture modifgier
      .chartAngleSelection(value: $selectedSales)
      
      .chartGesture { chart in
        SpatialTapGesture()
          .onEnded { event in
            let angle = chart.angle(at: event.location)
            chart.selectAngleValue(at: angle)
            inputSalesAmount = selectedDayData?.sales ?? 0
          }
        
      }
      
      // add a background that contains the selected day and it's sales amount
      .chartBackground { chartProxy in
        GeometryReader { geometry in
          let frame = geometry[chartProxy.plotFrame!]
          VStack(spacing: 2) {
            Text(selectedDayData?.day ?? "")
              .multilineTextAlignment(.center)
              .font(.body)
              .foregroundStyle(.secondary)
              .frame(width: 70, height: 40)
            Text("\(selectedDayData?.sales ?? 0, specifier: "%.2f")")
              .font(.headline)
              .fontWeight(.semibold)
              .foregroundStyle((selectedDayData != nil) ? Color.primary : .clear)
          }
          .position(x: frame.midX, y: frame.midY)
        }
      }
      
      // add a edit view to the bottom of the chart that contains a
      // textField and a button to update the sales amount for a
      // selected sector (selectedDayData)
      if chartItem.editMode {
        Spacer()
        Spacer()
        ChartEditForPieChartView(chartItem: $chartItem, selectedDayData: selectedDayData, inputSalesAmount: $inputSalesAmount)
      }
    }
    
  }
  
}

#Preview {
  PieChartView(chartItem: .constant(.defaultChartItem))
}

