//
//  ContentModel.swift
//  LearningApp
//
//  Created by Alex Andrews on 22/01/2023.
//

import Foundation

class ContentModel: ObservableObject {
    
    // list of modules
    @Published var modules = [Module]()
    
    // Current Module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explanation
    @Published var codeText  = NSAttributedString()
    var styleData: Data?
    
    // current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        getLocalData()
    }
    
    // Mark: - Data methods
    
    func getLocalData() {
        
        // Get url to json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // read file into data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // try to decode json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // assign parsed modules to muldes property
            self.modules = modules
        }
        catch {
            print("couldnt parse local data")
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")

        do {
            
            // read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            print("couldnt parse style data")
        }
        
    }
    
    // Mark: - Module navigation methods
    
    func beginModule(_ moduleid:Int) {
        // find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                
                // find the mathcing module
                currentModuleIndex = index
                break
            }
        }
        
        // set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int) {
        // check that the lesson is in range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // advance the lesson
        currentLessonIndex += 1
        
        // check whether it is in range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            // reset the lesson state
            currentLesson = nil
            currentLessonIndex = 0
        }
    }
    
    func hasNextLesson() -> Bool {
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleId:Int) {
        // set the current module
        beginModule(moduleId)
        
        // set the current question
        currentQuestionIndex = 0
        
        // if there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            // set the question content
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    // Mark: Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // add styling data
        if styleData != nil {
            data.append(self.styleData!)
        }
        
        // add html data
        data.append(Data(htmlString.utf8))
        
        
        
        // convert to attributed string
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                
                resultString = attributedString
            }
        
        return resultString
    }
}
