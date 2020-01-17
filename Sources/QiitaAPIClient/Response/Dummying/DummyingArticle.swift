//
//  DummyingArticle.swift
//  
//
//  Created by hicka04 on 2020/01/16.
//

import Foundation

#if DEBUG
extension Article: Dummying {
    
    public static func dummy() -> Article {
        Article(id: ID.dummy(),
                title: "ArticleTitle",
                tags: [Tag.dummy()],
                body: "#h1\n#h2",
                renderedBody: "<h1>h1</h1><h2>h2</h2>",
                url: URL(string: "https://www.google.co.jp")!,
                createdAt: Date(),
                updatedAt: Date(),
                likesCount: 10,
                user: User.dummy())
    }
}

extension Article.ID: Dummying {
    
    public static func dummy() -> Article.ID {
        Article.ID(rawValue: "ArticleID")
    }
}

extension Article.Tag: Dummying {
    
    public static func dummy() -> Article.Tag {
        Article.Tag(name: "Swift")
    }
}
#endif
