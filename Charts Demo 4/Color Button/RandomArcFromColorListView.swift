//
//  RandomArcFromColorListView.swift
//  Exploring Charts
//
//  Created by Michael Knych on 5/17/24.
//

import SwiftUI

struct RandomArcFromColorListView: View {
  // parameters of the struct
  let colors: [Color]
  let index: Int
  let minRadius: CGFloat
  let maxRadius: CGFloat
  let opacity: CGFloat
  
  // Random Constant
  // want endTrim to be larger than startTrim
  let startTrim = 0.0
  let endTrim: Double = 1.0
  
  // Computed properties
  var isValidIndex: Bool {
    index < colors.count && index >= 0
  }
  var theIndex: Int {
    isValidIndex ? index : 0
  }
  var count: CGFloat {
    CGFloat(colors.count)
  }
  var color: Color {
    colors[theIndex]
  }
  var endRadius: CGFloat {
    minRadius + maxRadius / count
  }
  var rotate: CGFloat {
    0.0
  }
  
    var body: some View {
      ArcView(color: color.opacity(opacity),
              startRadius: minRadius,
              endRadius: endRadius,
              startTrim: startTrim,
              endTrim: endTrim,
              rotate: rotate)
    }
}

#Preview {
  RandomArcFromColorListView(colors: Color.defaultColors,
                             index: 1,
                             minRadius: 170,
                             maxRadius: 180,
                             opacity: 0.9)
}
