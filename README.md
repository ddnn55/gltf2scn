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

Install carthage if you don't have it.

```
brew install carthage
```

Install deps

```
carthage bootstrap
```

Preprocess shaders

```
yarn
./bin/bundle_shaders.js
```

Develop!
