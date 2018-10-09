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
    Option<String>("merge", default: "/dev/null", description: "Path a .scn file to merge with the input .glb"),
    Argument<String>("path", description: "Path to input .glb"),
    Argument<String>("outputPath", description: ".scn output path")
) { merge, path, outputPath in
    print("input \(path) output: \(outputPath) merge: \(merge)")
    
//    let exportDelegate = ExportDelegate()
    
    var scene: SCNScene
    do {
        let sceneSource = try GLTFSceneSource(path: path)
        scene = try sceneSource.scene()
        let success = scene.write(to: URL(fileURLWithPath: outputPath), options: nil, delegate: nil, progressHandler: nil)
        if(success) {
            print("Saved \(outputPath)")
        }
        else {
            print("Error while trying to save \(outputPath)")
            exit(1)
        }
    } catch {
        print("Error while converting scene: \(error.localizedDescription)")
        exit(1)
    }
    
}.run()





