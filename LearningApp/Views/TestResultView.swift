//
//  TestResultView.swift
//  LearningApp
//
//  Created by Alex Andrews on 12/02/2023.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var numCorrect:Int
    
    var resultHeading: String {
        
        guard model.currentModule != nil else {
            return ""
        }
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 {
            return "Awesome!"
        }
        else if pct > 0.2 {
            return "Doing Great"
        }
        else {
            return "Keep Learning"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("You scored \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0)")
            
            Spacer()
            
            Button {
                
                model.currentTestSelected = nil
                
            } label: {
                
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

