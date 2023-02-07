//
//  StoryListView.swift
//  HackerNews
//
//  Created by Ashish Jaiswal on 06/08/22.
//

import SwiftUI

struct StoryListView: View {
    @ObservedObject private var storyListVm = StoryListViewModel(webService: WebServiceImpl())
    var body: some View {
        NavigationView {
            List(storyListVm.stories, id: \.id) { storyVm in
                NavigationLink(destination: StroyDetailView(storyId: storyVm.id)) {
                       Text("\(storyVm.title)")
                }
            }
            .navigationBarTitle("Hacker News")
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
