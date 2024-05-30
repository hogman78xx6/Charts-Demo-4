//
//  MainViewWithTitleAndBorder.swift
//  Charts Demo 4
//
//  Created by Michael Knych on 5/26/24.
//

import SwiftUI

struct MainViewWithTitleAndBorder: View {
  @State var chartItem: ChartItem = .defaultChartItem
  @State var editTitle: Bool = false
  var borderColor: Color {
    .black
    .opacity(chartItem.showBorder ? 1.0 : 0.0)
  }
  var body: some View {
    VStack {
      // Top Buttons
      HStack {
        Button(action: {
          withAnimation {
            chartItem.editMode.toggle()
          }
          
        }, label: {
          Image(systemName: chartItem.editMode ? "checkmark" : "square.and.pencil")
        })
        if !chartItem.editMode {
          Spacer()
          Button(action: {
            withAnimation {
              // TODO: Sharing
            }
            
          }, label: {
            Image(systemName: "square.and.arrow.up")
          })
        }
      }
      .padding(.top)
      
      // Buttons and charts
      HStack {
        // ----- Left Chart Buttons ---------------------
        if chartItem.editMode  {
          LeftChartButtonsView(chartItem: $chartItem)
        }
        
        VStack(alignment: chartItem.titleAligment) {
          // this is the title ----------------
          if !editTitle {
            Text(chartItem.title)
              .font(.headline)
              .fontWeight(.semibold)
              .onTapGesture {
                editTitle.toggle()
              }
          } else {
            TextField(chartItem.title, text: $chartItem.title)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .onSubmit {
                editTitle.toggle()
              }
          }
          // ------- The chart ---------------------
          ContentView(chartItem: $chartItem)
            
        }  // end of title and chart contents
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 20)
            .stroke(borderColor)
        )
        .padding()
        // ----- Right Chart Buttons ------------------------
        if chartItem.editMode  {
          RightChartButtonsView(chartItem: $chartItem)
        }
      }
      
    }
  }
}

#Preview(traits: .landscapeRight) {
  MainViewWithTitleAndBorder()
}
