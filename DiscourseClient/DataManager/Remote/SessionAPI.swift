//
//  APIClient.swift
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation
import UIKit

enum SessionAPIError: Error {
    //case emptyData
    case httpError(Int)
    case apiError(ApiError)
}

/// Clase de utilidad para llamar al API. El método Send recibe una Request que implementa APIRequest y tiene un tipo Response asociado
final class SessionAPI {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    func send<T: APIRequest>(request: T, completion: @escaping(Result<T.Response?, Error>) -> ()) {
        let request = request.requestWithBaseUrl()
        
        let task = session.dataTask(with: request) { data, response, error in
            
            /*
             Data puede llegar vacío si:
             - La llamada ha sido correcta pero no llegan datos (DELETE de un topic).
             - La llamada es errónea, en cuyo caso error sería != nil y por tanto
             se quedaría en el análisis de response.
             */
            
            // Early exit si la respuesta tiene código de error
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 &&
                httpResponse.statusCode < 500 {
                
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(ApiError.self, from: data)
                        DispatchQueue.main.async {
                            completion(.failure(SessionAPIError.apiError(model)))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(SessionAPIError.httpError(httpResponse.statusCode)))
                    }
                    
                }
                return
            }
            
            do {
                if let data = data, !data.isEmpty {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.success(nil))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            /*

            // Si vuelven datos, los intentamos decodificar
            if let data = data, data.count > 0 {
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                // Si no vuelven datos, pero tampoco hay error, lo consideramos success,
                // para el caso de delete topic sobre todo.
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            }
             
            */

        }
        task.resume()
    }
}

struct ApiError: Codable {
    let action: String?
    let errors: [String]?
}
