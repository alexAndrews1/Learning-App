//
//  TestView.swift
//  LearningApp
//
//  Created by Alex Andrews on 11/02/2023.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // question
                CodeTextView()
                
                // answers
                
                // button
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
