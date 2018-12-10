//
//  main.swift
//  gltf2scn
//
//  Created by Stolarsky, David on 6/12/18.
//  Copyright © 2018 The New York Times. All rights reserved.
//

import Foundation
import SceneKit


//class ExportDelegate: NSObject, SCNSceneExportDelegate {
//    func write(_ image: NSImage, withSceneDocumentURL documentURL: URL, originalImageURL: URL?) -> URL? {
//        print("hello from image export func!")
//        return URL(string: "https://placekitten.com/g/1024/1024")
//    }
//}


command(
    Option<String>("template", default: "", description: "Path to a .scn file into which the .glb will be inserted"),
    Option<String>("template-parent-node", default: "", description: "Name of node in the template .scn under which the contents of the .glb will be added"),
    Flag("embed-external-images", default: true, description: "Whether or not external images should be embedded in the resulting .scn"),
    Argument<String>("path", description: "Path to input .glb"),
    Argument<String>("outputPath", description: ".scn output path")
) { templatePath, templateParentNode, embedExternalImages, path, outputPath in
    print("embedExternalImages", embedExternalImages)
//    let exportDelegate = ExportDelegate()
    
    var scene: SCNScene
    var templateScene = SCNScene()
    var parentNode: SCNNode
    do {
        let sceneSource = try GLTFSceneSource(path: path, embedExternalImages: embedExternalImages)
        scene = try sceneSource.scene()
        
        if templatePath != "" {
            if templateParentNode == "" {
                print("Usage error: if you pass --template you must also pass --template-parent-node")
                exit(1)
            }
            print("Adding \(templatePath) to \(templateParentNode)")
            let templateUrl = URL(fileURLWithPath: templatePath)
            do {
                templateScene = try SCNScene(url: templateUrl)
//                let potentialParentNodes = scene.rootNode.childNodes(passingTest: {node, ptr in node.name == templateParentNode})
//                if potentialParentNodes.count < 1 {
//                    print("Usage error: could not find a node named \(templateParentNode) in \(path)")
//                    exit(1)
//                }
//                if potentialParentNodes.count > 1 {
//                    print("Usage warning: found \(potentialParentNodes.count) nodes named \(templateParentNode) in \(path). Will use the first one we found.")
//                }
                
                // add .scn to .glb's VRN
//                let parentNode = potentialParentNodes[0]
//                templateScene.rootNode.childNodes.forEach { node in
//                    parentNode.addChildNode(node)
//                }
                
            }
            catch {
                print("Error while loading \(templatePath). Does it exist? Is it a valid SceneKit scene?")
                exit(1)
            }
            
            guard let _parentNode = templateScene.rootNode.childNode(withName: templateParentNode, recursively: true) else {
                print("Error: could not find node \(templateParentNode) in \(templatePath)")
                exit(3)
            }
            parentNode = _parentNode
        }
        else {
            parentNode = templateScene.rootNode
        }
        
        // add .glb to .scn's templateParentNode
        scene.rootNode.childNodes.forEach { node in
            parentNode.addChildNode(node)
        }
        
        
        let success = templateScene.write(to: URL(fileURLWithPath: outputPath), options: nil, delegate: nil, progressHandler: nil)
        if(success) {
            print("Saved \(outputPath)")
        }
        else {
            print("Error while trying to save \(outputPath)")
            exit(1)
        }
    } catch {
        print("Error: \(error.localizedDescription)")
        exit(1)
    }
    
}.run()





