//
//  StroyDetailView.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 06/08/22.
//

import SwiftUI

struct StroyDetailView: View {
    
    @ObservedObject private var storyDetailVm: StoryDetailViewModel
    var storyId: Int
    init(storyId: Int) {
        self.storyId = storyId
        self.storyDetailVm = StoryDetailViewModel(webService: WebServiceImpl())
    }
    var body: some View {
        VStack {
            Text("\(self.storyDetailVm.title)")
            Webview(url: self.storyDetailVm.url)
        }.onAppear {
            self.storyDetailVm.fetchStoryDetails(storyId: self.storyId)
        }
    }
}

struct StroyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StroyDetailView(storyId: 8863)
    }
}
