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
    let lastPostedAt: String
    let lastPoster: String
    let posters: [Poster]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case postsCount = "posts_count"
        case lastPostedAt = "last_posted_at"
        case lastPoster = "last_poster_username"
        case posters
    }
}

struct Poster: Codable {}
