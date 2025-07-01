//
//  ClientAPI.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation

struct ClientAPI: ClientAPIProtocol {
    private let cache = URLCache(
        memoryCapacity: 20 * 1024 * 1024,
        diskCapacity: 100 * 1024 * 1024,
        diskPath: "responseCache"
    )

    private let cacheDuration: TimeInterval = 60

    func dispatch<R>(_ request: R) async throws -> R.ReturnType where R : Request {
        do {

            // Create URL Request
            guard let url = URL(string: request.url) else { throw NetworkRequestError.invalidRequest }
            var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData

            // Create URL Session Config
            let urlSessionConfig = URLSessionConfiguration.default
            urlSessionConfig.urlCache = cache
            urlSessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData

            // Create URL Session
            let urlSession = URLSession(configuration: urlSessionConfig)

            // Check Cache
            if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: urlRequest),
                  let timestamp = cachedResponse.userInfo?["timestamp"] as? Date {
                   let age = Date().timeIntervalSince(timestamp)
                   if age < cacheDuration {
                       return try processData(request: request, data: cachedResponse.data)
                   }
            }

            // Hit API
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            let response = try processData(request: request, data: data) // Convert JSON Response to Desired Response Model

            // Set Cache from Success Response
            let cache = CachedURLResponse(response: urlResponse, data: data, userInfo: ["timestamp": Date()], storagePolicy: .allowed)
            urlSession.configuration.urlCache?.storeCachedResponse(cache, for: urlRequest)


            return response
        } catch {
            throw error
        }
    }

    private func processData<R: Request>(request: R, data: Data) throws -> R.ReturnType {
        do {
            let response = try JSONDecoder().decode(R.ReturnType.self, from: data)
            return response
        } catch {
            throw error
        }
    }
}
