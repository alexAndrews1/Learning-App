//
//  ContentDetailVew.swift
//  LearningApp
//
//  Created by Alex Andrews on 04/02/2023.
//

import SwiftUI
import AVKit

struct ContentDetailVew: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // only show video if we get a valid url
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Description
            CodeTextView()
            
            // Next lesson button
            
            // show next lesson only is there is one
            if model.hasNextLesson() {
                Button(action: {
                    // advance the lesson
                    model.nextLesson()
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height:48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            
                    }
                })
                
            }
            else {
                // show "complete" button
                Button(action: {
                    // take use back to homeview
                    model.currentContentSelected = nil
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height:48)
                        
                        Text("Complete")
                            .foregroundColor(.white)
                            
                    }
                })
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
        
    }
}

struct ContentDetailVew_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailVew()
    }
}
