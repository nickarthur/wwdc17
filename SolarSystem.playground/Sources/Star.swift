import SceneKit
import UIKit

/*
 Star.swift
 
    * Separate class for stars, used so that they can have a "glow" effect
    * Also does not require other methods like those included in the planet class.
 
*/

public class Star {
    var name: String
    var imageMap: UIImage
    var radius: CGFloat
    var distanceFromCentre: Double
    var node: SCNNode
    
    init(name: String, image: UIImage, radius: CGFloat, distanceFromCentre: Double) {
        self.name = name
        self.imageMap = image
        self.radius = radius
        self.distanceFromCentre = distanceFromCentre
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial!.diffuse.contents = self.imageMap
        sphere.firstMaterial?.emission.contents = self.imageMap
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3Make(Float(distanceFromCentre), 0, 0)
        self.node = node
    }
    
}
