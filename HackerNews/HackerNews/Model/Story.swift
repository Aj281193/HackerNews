//
//  Story.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 06/08/22.
//

import Foundation

struct Story: Codable {
    let id: Int
    let title: String
    let url: String
    
}

extension Story {
    static func placeholder() -> Story {
        return Story(id: 0, title: "N/A", url: "")
    }
}

struct StoryViewModel: Codable {
    
    let story: Story
    
    var id: Int {
        return self.story.id
    }
   var title: String {
        return self.story.title
    }
    var url: String {
        return self.story.url
    }
}

