//
//  Double.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 11.06.22.
//

import Foundation
extension Double{
    private var formaterToString : NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 3
        return numberFormatter
    }
    func format() -> String{
        let number = NSNumber(value: self)
        return formaterToString.string(from: number) ?? ""
    }
}
