import Foundation

// TODO: Implementar aquí el modelo de la respuesta.
// Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    let users: [User]
    let topicList: TopicList
    
    enum CodingKeys: String, CodingKey {
        case users
        case topicList = "topic_list"
    }
}

struct TopicList: Codable {
    let topics: [Topic]
}

struct Topic: Codable {
    let id: Int
    let title: String
    let postsCount: Int
    let createdAt: String
    let views: Int
    let lastPoster: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case createdAt = "created_at"
        case views
        case lastPoster = "last_poster_username"
    }
}
