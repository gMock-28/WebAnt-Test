//
//  NetworkErrors.swift
//  WebAnt Test MVP
//
//  Created by Gold_Mock on 24.10.2021.
//

import Foundation
import SwiftUI

enum Errors: Error {
    case noInternetConnection
    case unableToParseData
    case lastPage
}
