//
//  StoriesListViewModel.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 06/08/22.
//

import Foundation
import Combine

class StoryListViewModel: ObservableObject {
   @Published var stories = [StoryViewModel]()
    private var cancellable: AnyCancellable?
    
    private let webService: WebService?
    
    init(webService: WebService) {
        self.webService = webService
        self.fetchTopStories()
    }
    
    private func fetchTopStories() {
        cancellable = webService?.getAllTopStories().map { stories in
            stories.map {
                StoryViewModel(story: $0)
            }
        }.sink(receiveCompletion: {_ in}) { storyVm in
            self.stories = storyVm
        }
    }
}


