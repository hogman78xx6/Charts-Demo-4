//
//  Annotate Line Area Graph.swift
//  Charts Demo 4
//
//  Created by Michael Knych on 5/26/24.
//

import SwiftUI

struct Annotate_Line_Area_Graph: View {
  let chartItem: ChartItem
    var body: some View {
      VStack {
        if chartItem.editMode {
          Image(systemName: "square.and.pencil")
            .foregroundStyle(chartItem.lineAreaColor)
            .padding(3)
            .background(
            RoundedRectangle(cornerRadius: 5)
              .stroke(chartItem.lineAreaColor)
            )
            .opacity(0.7)
        } else {
          Circle()
            .fill(chartItem.lineAreaColor)
            .frame(width: 7, height: 7)
        }
      }
    }
}

#Preview {
  Annotate_Line_Area_Graph(chartItem: .defaultChartItem)
}
