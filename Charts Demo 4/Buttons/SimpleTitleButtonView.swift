//
//  SimpleTitleButtonView.swift
//  Charfts Demo 4
//
//  Created by Michael Knych on 5/22/24.
//

import SwiftUI

struct SimpleTitleButtonView: View {
  @Binding var titleAligment: HorizontalAlignment
  let myAlignment : HorizontalAlignment
  let iconName: String
  
  let selectedOpacity = 0.7
  let deselectedOpacity = 0.3
  
  var body: some View {
    Button(action: {
      withAnimation {
        titleAligment = myAlignment
      }
    }, label: {
      Image(systemName: iconName)
        .foregroundStyle(.black).opacity(titleAligment == myAlignment ? selectedOpacity: deselectedOpacity)
    })
  }
}


#Preview {
  SimpleTitleButtonView(titleAligment: .constant(.leading), myAlignment: .leading, iconName: "align.horizontal.left.fill")
}
