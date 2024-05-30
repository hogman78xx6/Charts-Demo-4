//
//  AreaChartVerticalView.swift
//  Charts Demo 3
//
//  Created by Michael Knych on 5/20/24.
//

import SwiftUI
import Charts

struct AreaChartVerticalView: View {
  let dailySales: [DailySalesType]
    var body: some View {
      Chart {
        ForEach(dailySales) { item in
          AreaMark(x: .value("Day", item.day),
                   y: .value("Sales", item.sales))
        }
      }
    }
}

#Preview {
  AreaChartVerticalView(dailySales: defaultDailySales)
}
