# gltf2scn
Convert glTF .glb files to SceneKit .scn files

## Installation

See Releases ☝️

## Usage

Write .scn to current directory

```
./gltf2scn my-scene.glb
```

Write .scn to specific path

```
./gltf2scn my-scene.glb /path/to/output.scn
```

## Develop

[GLTFSceneKit](https://github.com/magicien/GLTFSceneKit) does the real work. It was installed here using Carthage, but I couldn't figure out how to make the .framework work in a command line binary, so I moved the GLTFSceneKit files straight into this repo, and changed the shaders from being bundle files to being inline Swift strings.

Hence no need to run `carthage`.

You can regenerate the shader Swift strings via:

```
yarn
./bin/bundle_shaders.js
```
