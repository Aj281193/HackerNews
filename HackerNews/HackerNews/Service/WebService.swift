//
//  WebService.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 06/08/22.
//

import Foundation
import Combine

protocol WebService {
    func getAllTopStories() -> AnyPublisher<[Story], Error>
    func getStoryById(id: Int) -> AnyPublisher<Story, Error>
}

class  WebServiceImpl: WebService {
    
    
    func getStoryById(id: Int) -> AnyPublisher<Story, Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty") else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url).receive(on: RunLoop.main)
            .map(\.data).decode(type: Story.self, decoder: JSONDecoder())
            .catch {_ in Empty<Story,Error>() }
            .eraseToAnyPublisher()
            
    }
    
    
    
    func getAllTopStories() -> AnyPublisher<[Story], Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url).receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap{ storyIds in
                self.mergeStories(id: storyIds)
            }.scan([]) { stories, story  in
                return stories + [story]
            }
            .eraseToAnyPublisher()
    }
    
    
    private func mergeStories(id storyIds: [Int]) -> AnyPublisher<Story,Error> {
        
        let storyIds = Array(storyIds.prefix(50))
        
        let initialPublisher = getStoryById(id: storyIds[0])
        let remainder = Array(storyIds.dropFirst())
        
        return remainder.reduce(initialPublisher) { combined, id in
            return combined.merge(with: getStoryById(id: id))
                .eraseToAnyPublisher()
        }
    }
}
