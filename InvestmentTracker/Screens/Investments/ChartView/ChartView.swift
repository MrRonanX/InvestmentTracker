//
//  ChartView.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/25/21.
//

import SwiftUI

struct ChartView: View {
    @StateObject var chartVM = ChartViewModel()
    @State var height: CGFloat
    
    var asset: Investment
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: height / CGFloat(chartVM.steps.count)) {
                ForEach(chartVM.steps, id:\.self) { step in
                    VStack(alignment: .trailing, spacing: 0) {
                        Text(String(step).croppedPrice ?? "0")
                            .font(.caption2)
                            .foregroundColor(Color(uiColor: UIColor.systemGray4))
                            .padding(.trailing, 10)
                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(uiColor: UIColor.systemGray4))
                    }
                }
            }
            
            HStack(alignment: .bottom, spacing: 4) {
                ForEach(chartVM.candleData) { candle in
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 1, height: chartVM.candleTopShadow(candle))
                        Rectangle()
                            .frame(width: 6, height: chartVM.candleBody(candle))
                        Rectangle()
                            .frame(width: 1, height: chartVM.candleBottomShadow(candle))
                    }
                    .foregroundColor(candle.candleColor)
                    .offset(y: -chartVM.bottomOffset(candle))
                }
            }
            .padding(.trailing, 40)
            .alignmentGuide(.bottom) { $0[.bottom] }
            
            if chartVM.isLoading {
                LoadingView()
            }
        }
        .task {
            activateVM()
            await chartVM.downloadDayData(with: asset.code)
        }
    }
    
    private func activateVM() {
        chartVM.asset = asset
        chartVM.height = height
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(height: 500, asset: Investment(from: Stock()))
    }
}
