//
//  StoryDetailViewModel.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 06/08/22.
//

import Foundation
import Combine

class StoryDetailViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    @Published private var story = Story.placeholder()
    
    private var webService: WebService?
    
    init(webService: WebService) {
        self.webService = webService
        
    }
    
    func fetchStoryDetails(storyId: Int) {
        print("call story detail")
        self.cancellable = webService?.getStoryById(id: storyId)
            .catch {_ in Just(Story.placeholder())}
            .sink(receiveCompletion: { _ in }, receiveValue: { story in
            self.story = story
        })
    }
    
}

extension StoryDetailViewModel {
    
    var title: String {
        return self.story.title
    }
    
    var url: String {
        return self.story.url
    }
}
