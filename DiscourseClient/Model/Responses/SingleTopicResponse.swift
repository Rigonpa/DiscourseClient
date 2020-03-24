import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let id: Int
    let title: String
    let closed: Bool
    let details: Details
}

struct Details: Codable {
    let canDelete: Bool?
    
    enum CodingKeys: String, CodingKey {
        case canDelete = "can_delete"
    }
}

