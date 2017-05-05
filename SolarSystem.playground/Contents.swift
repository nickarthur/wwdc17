import PlaygroundSupport

//: ## Solar System
//: **Designed and Developed by Jay Lees**
//:
//: Solar System utilises SceneKit and UIKit to create an interactive 3D model of the solar system.
//: The model gives information relating to each planet,  as well interactive camera control that allows the user to fly through space.
//: Use swipe gestures to fly between each planet as well as an overall view of the solar system
//:
//: External Sources:
//: - [Background music](https://www.dl-sounds.com/royalty-free/unknown-planet/)
//: - [Planet data](https://nssdc.gsfc.nasa.gov/planetary/factsheet/)
//: - [Font](http://www.dafont.com/caviar-dreams.font)
//: - [Planet Textures](http://www.solarsystemscope.com/textures/)


let viewController = SolarSystemViewController(width: 760, height: 600)
PlaygroundPage.current.liveView = viewController
