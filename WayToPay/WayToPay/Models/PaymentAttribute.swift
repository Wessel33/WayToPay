//
//  PaymentAttribute.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import Foundation

enum PaymentAttribute: Codable {
    case cashback(rate: SafeDecimal)
    case cashbackSaving(cashbackRate: SafeDecimal, savingsRate: SafeDecimal, years: Int = 1)
    case roundUp(factor: SafeDecimal, rate: SafeDecimal, years: Int = 1)
    
    func names() -> [String] {
        switch self {
        case .cashback(rate: let rate):
            return ["Cashback", "\(rate.value)%"]
        case let .cashbackSaving(cashbackRate, savingsRate, years):
            var names = [
                "Cashback into savings",
                "\(cashbackRate.value)%",
                "AER \(savingsRate.value)%"
            ]
            
            if years > 1 {
                names.append("\(years)yrs")
            }
            
            return names
        case let .roundUp(factor, rate, years):
            var names: [String] = ["Round up"]
            
            if factor.value != 1 {
                names.append("\(factor.value)x")
            }
            
            names.append("AER \(rate.value)%")
            
            if years > 1 {
                names.append("\(years)yrs")
            }
            
            return names
        }
    }
    
    func calculateSavings(for value: Money) -> Money {
        switch self {
        case .cashback(let rate):
            return calculateCashback(
                on: value,
                rate: rate
            )
        case let .cashbackSaving(cashbackRate, savingsRate, years):
            return calculateCashbackSavings(
                on: value,
                cashbackRate: cashbackRate,
                savingsRate: savingsRate,
                years: years
            )
        case let .roundUp(factor, rate, years):
            return calculateRoundUp(
                on: value,
                factor: factor,
                rate: rate,
                years: years
            )
        }
    }
    
    private func calculateCashback(on value: Money, rate: SafeDecimal) -> Money {
        return value %* rate
    }
    
    private func calculateCashbackSavings(
        on value: Money,
        cashbackRate: SafeDecimal,
        savingsRate: SafeDecimal,
        years: Int
    ) -> Money {
        let cashbackAmount = calculateCashback(on: value, rate: cashbackRate)
        let savings = applyGrowth(to: cashbackAmount, rate: savingsRate, years: years)
        
        return savings
    }
    
    private func calculateRoundUp(
        on value: Money,
        factor: SafeDecimal,
        rate: SafeDecimal,
        years: Int
    ) -> Money {
        let roundUpAmount = (value.roundUpToPound() - value) * factor
        let finalValue = applyGrowth(to: roundUpAmount, rate: rate, years: years)
        let interestEarned = finalValue - roundUpAmount
       
        return interestEarned
    }
    
    private func applyGrowth(to startingValue: Money, rate: SafeDecimal, years: Int) -> Money {
        var finalValue = startingValue

        for _ in 1...years {
            finalValue = finalValue %+ rate
        }
        
        return finalValue
    }
}
