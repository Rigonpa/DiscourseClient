import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

/*
 Vaya! Se te ha olvidado usar CamelCase aquí 
 */
struct AddNewTopicResponse: Codable {
    let id: Int
    let created_at: String
    let topic_slug: String
}
