//
//  main.swift
//  gltf2scn
//
//  Created by Stolarsky, David on 6/12/18.
//  Copyright © 2018 The New York Times. All rights reserved.
//

import Foundation
import SceneKit
//import GLTFSceneKit

//let arg = String.fromCString(C_ARGV[0])

//let path = CommandLine.arguments[1]
let path = "/Users/205740/go/src/github.com/KhronosGroup/glTF-Sample-Models/2.0/Corset/glTF/Corset.gltf"

var scene: SCNScene
do {
    let sceneSource = try GLTFSceneSource(path: path)
    scene = try sceneSource.scene()
} catch {
    print("error while converting scene: \(error.localizedDescription)")
//    return
}

print("hi there!")
print(path)

