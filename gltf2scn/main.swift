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
    Option<String>("merge", default: "", description: "Path to a .scn file to merge with the input .glb"),
    Option<String>("merge-parent-node", default: "", description: "Name of node in .glb scene to which .scn scene will be parented"),
    Argument<String>("path", description: "Path to input .glb"),
    Argument<String>("outputPath", description: ".scn output path")
) { mergePath, mergeParentNode, path, outputPath in
    
//    print("input \(path) output: \(outputPath) merge: \(merge)")
    
//    let exportDelegate = ExportDelegate()
    
    var scene: SCNScene
    do {
        let sceneSource = try GLTFSceneSource(path: path)
        scene = try sceneSource.scene()
        
        if mergePath != "" {
            if mergeParentNode == "" {
                print("Usage error: if you pass --merge you must also pass --merge-parent-node")
                exit(1)
            }
            print("Adding \(mergePath) to \(mergeParentNode)")
            let mergeUrl = URL(fileURLWithPath: mergePath)
            do {
                let mergeScene = try SCNScene(url: mergeUrl)
                let potentialParentNodes = scene.rootNode.childNodes(passingTest: {node, ptr in node.name == mergeParentNode})
                if potentialParentNodes.count < 1 {
                    print("Usage error: could not find a node named \(mergeParentNode) in \(path)")
                    exit(1)
                }
                if potentialParentNodes.count > 1 {
                    print("Usage warning: found \(potentialParentNodes.count) nodes named \(mergeParentNode) in \(path). Will use the first one we found.")
                }
                let parentNode = potentialParentNodes[0]
                parentNode.addChildNode(mergeScene.rootNode)
            }
            catch {
                print("Error while loading \(mergePath). Does it exist? Is it a valid SceneKit scene?")
                exit(1)
            }
        }
        
        let success = scene.write(to: URL(fileURLWithPath: outputPath), options: nil, delegate: nil, progressHandler: nil)
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





