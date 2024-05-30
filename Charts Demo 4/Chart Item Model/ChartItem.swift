//
//  ChartItem.swift
//  Charfts Demo 4
//
//  Created by Michael Knych on 5/24/24.
//

import SwiftUI

struct ChartItem: Identifiable {
  let id = UUID()
  var dailySales: [DailySalesType]
  var barColors: [Color]
  var editMode: Bool
  var selectedDay: String
  var min: Double
  var max: Double
  var title: String
  var titleAligment: HorizontalAlignment
  var chartType: ChartType
  var isVerticalChart: Bool
  var intMode: Bool
  var lineAreaColor: Color
  var showBorder: Bool
  
  static let defaultChartItem: ChartItem = .init(
    dailySales: defaultDailySales,
    barColors: defaultBarColors,
    editMode: true,
    selectedDay: "Wed",
    min: 0,
    max: 1000,
    title: "Happy New Year",
    titleAligment: .leading,
    chartType: .bar,
    isVerticalChart: true, intMode: true,
    lineAreaColor: .purple,
    showBorder: true
  )
}
