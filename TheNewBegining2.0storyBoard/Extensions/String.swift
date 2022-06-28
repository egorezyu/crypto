//
//  String.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 28.06.22.
//

import Foundation
extension String{
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
