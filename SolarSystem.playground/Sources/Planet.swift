import SceneKit
import UIKit

/*
 Planet.swift
 
    *Used to create planets in the solar system and relevant methods, such as animation and spin

*/


public class Planet {
    //MARK: - Attribute Declarations
    var planetName: String
    var imageMap: UIImage
    var radius: CGFloat
    var distanceFromCentre: Double
    var node: SCNNode
    var infoView: InfoViewer
    
    //MARK: - Inititaliser
    init(planetName: String, image: UIImage, radius: CGFloat, distanceFromCentre: Double, planetInfo: planetInfo) {
        self.planetName = planetName
        self.imageMap = image
        self.radius = radius
        self.distanceFromCentre = distanceFromCentre
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial!.diffuse.contents = self.imageMap
        let node = SCNNode(geometry: sphere)
        node.position = SCNVector3Make(Float(distanceFromCentre), 0, 0)
        self.node = node
        self.infoView = InfoViewer(planetName: planetName, planetMass: planetInfo.mass, planetDiameter: planetInfo.diameter, lengthOfDay: planetInfo.lengthOfDay, distanceFromSun: planetInfo.distanceFromSun, temperature: planetInfo.temperature)
    }
    
    //MARK: - Rotation Around Sun
    
    //Given a time interval, animate the planet's rotation around the sun (in a circle)
    private func createAction(duration: TimeInterval) -> SCNAction {
        var arrayOfMoves = [SCNAction]()
        var theta = 0.0
        while theta < 2*Double.pi {
            let newX = cos(theta) * distanceFromCentre
            let newY = sin(theta) * distanceFromCentre
            arrayOfMoves.append(SCNAction.move(to: SCNVector3(x: Float(newX), y:0, z: Float(newY)), duration: duration/60))
            theta += 0.1
        }
        
        return SCNAction.repeatForever(SCNAction.sequence(arrayOfMoves))
    }
    
    //Call the create action function on the node that then execute the action
    func animate(withTime: TimeInterval){
        node.runAction(createAction(duration: withTime))
    }
    
    
    //MARK: - Translucent Path Generation
    
    //Create line that shows the path the planet will take in its rotation around the sun
    func createPath() -> SCNNode {
        let torus = SCNTorus(ringRadius: CGFloat(distanceFromCentre), pipeRadius: 1.5)
        let torusNode = SCNNode(geometry: torus)
        torusNode.opacity = 0.5
        torus.firstMaterial?.diffuse.contents  = UIColor.gray
        return torusNode
    }
    
    //MARK: - Ring Generation
    
    //Generate a ring around the planet given a texture
    func addRing(texture: String) {
        let ring = SCNTube(innerRadius: radius + 60, outerRadius: radius + 200, height: 5)
        ring.firstMaterial?.diffuse.contents = UIImage(named: texture)!
        let ringNode = SCNNode(geometry: ring)
        node.addChildNode(ringNode)
    }
    
    //MARK: - Planet Rotation about X-Axis
    
    //Rotates the planet around the X-Axis for when the user is zoomed in
    func startSpin(){
        if node.animationKeys.contains("planetRotation") {
            node.resumeAnimation(forKey: "planetRotation")
        } else {
            let animation = CABasicAnimation(keyPath: "rotation")
            animation.duration = 15.0
            animation.fromValue = NSValue(scnVector4: SCNVector4Make(0, 1, 0, 0))
            animation.toValue = NSValue(scnVector4: SCNVector4Make(0, 1, 0, Float.pi * 2.0))
            animation.repeatCount = 5000
            node.addAnimation(animation, forKey: "planetRotation")
        }
    }
    
    //Stops rotation around the X-axis when user switches planet
    func stopSpin(){
        node.pauseAnimation(forKey: "planetRotation")
    }
    
}
