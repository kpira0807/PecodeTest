import Foundation

struct NewsAPI: Decodable {
    var status: String
    var articles: [Articles]
}

