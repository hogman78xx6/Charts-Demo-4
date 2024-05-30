//
//  TitleAlignmentButton.swift
//  Charfts Demo 4
//
//  Created by Michael Knych on 5/22/24.
//

import SwiftUI

struct TitleAlignmentButton: View {
  @Binding var titleAligment: HorizontalAlignment
  
    var body: some View {
      VStack(spacing: 20) {
        SimpleTitleButtonView(titleAligment: $titleAligment, myAlignment: .leading, iconName: "align.horizontal.left.fill")
        
        SimpleTitleButtonView(titleAligment: $titleAligment, myAlignment: .center, iconName: "align.horizontal.center.fill")
        
        SimpleTitleButtonView(titleAligment: $titleAligment, myAlignment: .trailing, iconName: "align.horizontal.right.fill")
      }
      .padding(6)
      .overlay {
        RoundedRectangle(cornerRadius: 5)
          .stroke(lineWidth: 0.3)
      }
    }
}


#Preview {
  TitleAlignmentButton(titleAligment: .constant(.center))
}
