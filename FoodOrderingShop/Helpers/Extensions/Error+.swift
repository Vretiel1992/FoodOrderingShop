//
//  Error+.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import Foundation

extension Error {
    var isNoInternetConnection: Bool {
        switch (self as NSError).code {
        case URLError.Code.notConnectedToInternet.rawValue,
            URLError.Code.networkConnectionLost.rawValue:
            return true
        default:
            return false
        }
    }
}
