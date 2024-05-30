//
//  AreaChartHorizontalView.swift
//  Charts Demo 3
//
//  Created by Michael Knych on 5/20/24.
//

import SwiftUI
import Charts

struct AreaChartHorizontalView: View {
  let dailySales: [DailySalesType]
  var body: some View {
    Chart {
      ForEach(dailySales) { item in
        AreaMark(x: .value("Sales", item.sales),
                 y: .value("Day", item.day))
      }
    }
  }
}

#Preview {
    AreaChartHorizontalView(dailySales: defaultDailySales)
}
