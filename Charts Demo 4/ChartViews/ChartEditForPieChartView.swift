//
//  ChartEditForPieChartView.swift
//  Charts Demo 4
//
//  Created by Michael Knych on 5/29/24.
//

import SwiftUI

struct ChartEditForPieChartView: View {
  @Binding var chartItem: ChartItem
  let selectedDayData: DailySalesType?
  @Binding var inputSalesAmount: Double
  
  var min: Double {
    chartItem.min
  }
  
  var max: Double {
    chartItem.max
  }
  
  @State private var updateButtonDisabled: Bool = true
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      if selectedDayData != nil {
        Text("\(String(describing: selectedDayData!.day))     ")
          .font(.caption)
          .foregroundStyle(.primary)
        
        TextField("input number", value: $inputSalesAmount, format: .number)
          .keyboardType(.numbersAndPunctuation)
          .textFieldStyle(.roundedBorder)
          .font(.caption)
          .fontWeight(.semibold)
          .foregroundStyle(Color.primary)
          .frame(width: 60, height: 40)
        Button {
          if selectedDayData!.sales != inputSalesAmount {
            setSalesOfSelectedDay(dailySales: &chartItem.dailySales, selectedDay: selectedDayData!.day, sales: inputSalesAmount, min: min, max: max)
          }
          
          updateButtonDisabled = true
          
        } label: {
          Text("Update")
        }
        .buttonStyle(.borderedProminent)
        .disabled(updateButtonDisabled)
        
      }
      
    }
    .onSubmit {
      print("inputSalesAmount: \(inputSalesAmount)")
      if selectedDayData!.sales != inputSalesAmount {
        updateButtonDisabled = false
        
      }
      
    }
  }
}


