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
    
    var styleData: Data?
    
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
    
}
