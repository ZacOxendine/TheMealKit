import Foundation
import Network

// MARK: - Networking Service

class NetworkingService {
    // Request & Decode Data || Handle Errors from Endpoints
    typealias Handler<T: Decodable> = (Result<T, NetworkingError>) -> Void
    func fetch<T: Decodable>(_ endpoint: Endpoint, handler: @escaping Handler<T>) {
        getStatus(handler: { status in
            if status == .requiresConnection || status == .unsatisfied {
                return handler(.failure(.deviceOffline))
            } else {
                guard let url = endpoint.url else {
                    return handler(.failure(.invalidURL))
                }

                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data else {
                        return handler(.failure(.missingData))
                    }

                    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                        return handler(.failure(.undecodedData))
                    }

                    return handler(.success(decodedData))
                }.resume()
            }
        })
    }

    // Get Network Path Status
    private func getStatus(handler: @escaping (NWPath.Status) -> Void) {
        let pathMonitor = NWPathMonitor()
        let dispatchQueue = DispatchQueue(label: "Path Monitor")

        pathMonitor.start(queue: dispatchQueue)

        pathMonitor.pathUpdateHandler = { path in
            return handler(path.status)
        }

        pathMonitor.cancel()
    }
}
