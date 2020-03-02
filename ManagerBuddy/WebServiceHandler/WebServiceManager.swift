//
//  WebServiceManager.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 02/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

// MARK: - URLMethods Enum
enum URLMethod {
    case Get
    case Post
    case Put
    case Delete
}

class WebServiceManager {

    // MARK: - WebServiceManager Basic Methods

    func jsonData(forURLString urlString: String, andMethod method: URLMethod) {
        guard let url: URL = URL(string: urlString)
            else {
                parseError(withString: ErrorConstants.urlMismatched)
                return
        }
        switch method {
        case .Get:
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    self?.parseError(withString: error.localizedDescription)
                    return
                }
                if let data = data {
                    self?.parseData(withData: data)
                    return
                }
                self?.parseError(withString: ErrorConstants.tryAgain)
            }
        default:
            break
        }
    }

    // MARK: - Child class implementation Methods (if required)

    func parseData(withData data: Data) {}
    func parseError(withString errorString: String) {}
}
