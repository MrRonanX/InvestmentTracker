//
//  ChartViewModel.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/25/21.
//

import SwiftUI

@MainActor
final class ChartViewModel: ObservableObject {
    
    @Published var candleData = [DayCandle]()
    @Published var height = 200.0
    @Published var alert: AlertItem? = nil
    @Published var isLoading = false
    var asset: Investment?
    
    private var service = InvestmentsService.shared
    private var persistence = PersistenceManager.shared
    

    
    func downloadDayData(with asset: String) async {
        guard candleData.isEmpty else { return }
        isLoading = true
        let route = APIRouter.getMonthlyData(asset: asset)
        let result = await service.getDayCandles(route)
        isLoading = false
        switch result {
        case .success(let dayData):
            let data = dayData.daySeries.sorted  { $0.key > $1.key }.map { $0.value }
            guard data.count > 30 else { return }
            candleData = Array(data.prefix(30)).reversed()
            applyPriceChange()


        case .failure(let error):
            alert = AlertContext.alertWith(message: error.description)
        }
    }
    
    func applyPriceChange() {
        guard candleData.count > 1 else { return }
        asset?.dayChangePrice = candleData[0].closePrice - candleData[1].closePrice
        persistence.save()
    }
    
    var highestPrice: Double {
        let allHighs = candleData.compactMap { Double($0.high) }
        let max = allHighs.max() ?? 0
        return max * 1.05
    }
    
    var lowestPrice: Double {
        let allLows = candleData.compactMap { Double($0.low) }
        let min = allLows.min() ?? 0
        return min / 1.05
    }
    
    var steps: [Double] {
        var result = [Double]()
        let volume = highestPrice - lowestPrice
        let step = volume / 3
        var currentStep = max(highestPrice, lowestPrice)
        for _ in 0..<4 {
            result.append(currentStep)
            currentStep -= step
        }
        return result
    }
    
    func candleTopShadow(_ candle: DayCandle) -> CGFloat {
        let shadowTop = candle.highPrice
        let shadowBottom = candle.topBodyPrice
        let itemHeight = calculateYPoint(shadowBottom) - calculateYPoint(shadowTop)
        return max(itemHeight, 1)
    }
    
    func candleBody(_ candle: DayCandle) -> CGFloat {
        let bodyTop = candle.topBodyPrice
        let bodyBottom = candle.bottomBodyPrice

        let itemHeight = calculateYPoint(bodyBottom) - calculateYPoint(bodyTop)

        return max(itemHeight, 1)
    }
    
    func candleBottomShadow(_ candle: DayCandle) -> CGFloat {
        let shadowTop = candle.bottomBodyPrice
        let shadowBottom = candle.lowPrice
        let itemHeight = calculateYPoint(shadowBottom) - calculateYPoint(shadowTop)

        return max(itemHeight, 1)
    }
    
    func bottomOffset(_ candle: DayCandle) -> CGFloat {
        let shadowBottom = candle.lowPrice
        return height - calculateYPoint(shadowBottom)
    }

    
    func calculateYPoint(_ point: Double) -> CGFloat {
        (highestPrice - point) * height / viewHeight
    }
    
    var viewHeight: CGFloat {
        highestPrice - lowestPrice
    }
}
