import SceneKit
import UIKit
import AVFoundation

/*
 SolarSystemViewController.swift
 
    * Main View Controller for the project - instantiates and deals with all interaction with view
 
*/

public class SolarSystemViewController: UIViewController {
    
    //MARK: - Attributes Declaration
    var viewWidth = 0
    var viewHeight = 0
    var sceneView = SCNView()
    var scene = SCNScene()
    let cameraNode = SCNNode()
    let instView = UIImageView(frame: CGRect(x: 0, y: 0, width: 760, height: 600))
    var inSideView = false
    var planetsRotating = false
    var inOpeningSequence = false
    var currentPlanet: Planets = .Sun
    var audioPlayer = AVAudioPlayer()
    
    //MARK: - Inititaliser
    public init(width: Int, height: Int){
        super.init(nibName: nil, bundle: nil)
        viewWidth = width
        viewHeight = height
        preferredContentSize = CGSize(width: width, height: height)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Load Method
    
    //Sets up view and calls all relevant setup functions
    override public func viewDidLoad() {
        sceneView = SCNView(frame:CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        sceneView.backgroundColor = .clear
        self.view.addSubview(sceneView)
        sceneView.scene = scene
        
        startBackgroundMusic()
        setupGestureRecognizers()
        setupBackground()
        setupPlanets()
        setupCamera()
        createButtons()
        runOpeningSequence()
    }
    
    
    //MARK: - View Setup and Breakdown Methods
    
    //Adds planet nodes and planet rotation paths to the scene
    func setupPlanets(){
        saturn.addRing(texture: "2k_saturn_ring+alpha.png")
        scene.rootNode.addChildNode(mercury.node)
        scene.rootNode.addChildNode(venus.node)
        scene.rootNode.addChildNode(earth.node)
        scene.rootNode.addChildNode(mars.node)
        scene.rootNode.addChildNode(jupiter.node)
        scene.rootNode.addChildNode(saturn.node)
        scene.rootNode.addChildNode(uranus.node)
        scene.rootNode.addChildNode(neptune.node)
        scene.rootNode.addChildNode(sun.node)
        
        scene.rootNode.addChildNode(mercury.createPath())
        scene.rootNode.addChildNode(venus.createPath())
        scene.rootNode.addChildNode(earth.createPath())
        scene.rootNode.addChildNode(mars.createPath())
        scene.rootNode.addChildNode(jupiter.createPath())
        scene.rootNode.addChildNode(saturn.createPath())
        scene.rootNode.addChildNode(uranus.createPath())
        scene.rootNode.addChildNode(neptune.createPath())
    }
    
    //Sets camera up in initial position
    func setupCamera(){
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(4000, 200, 0)
        cameraNode.eulerAngles = SCNVector3Make(0, Float.pi/2, 0)
        cameraNode.camera!.zFar = 12000.0
        scene.rootNode.addChildNode(cameraNode)
    }
    
    //Sets background up with image of stars
    func setupBackground(){
        let sphere = SCNSphere(radius: 9000)
        sphere.firstMaterial!.diffuse.contents = UIImage(named: "stars.jpg")
        sphere.firstMaterial!.isDoubleSided = true
        scene.rootNode.addChildNode(SCNNode(geometry: sphere))
    }
    
    //Creates the 3 buttons that are used in the view
    func createButtons(){
        let zoomInButton = UIButton(type: .custom)
        let zoomOutButton = UIButton(type: .custom)
        let getHelpButton = UIButton(type: .infoLight)
        zoomInButton.tag = 1
        zoomInButton.setTitle("+", for: .normal)
        zoomInButton.titleLabel!.font = UIFont(name: "CaviarDreams", size: 50)
        zoomInButton.setTitleColor(UIColor.white, for: .normal)
        zoomInButton.setTitleColor(UIColor.gray, for: .highlighted)
        
        zoomOutButton.tag = 2
        zoomOutButton.setTitle("-", for: .normal)
        zoomOutButton.setTitleColor(.white, for: .normal)
        zoomOutButton.setTitleColor(UIColor.gray, for: .highlighted)
        zoomOutButton.titleLabel!.font = UIFont(name: "CaviarDreams", size: 50)
    
        getHelpButton.tintColor = .white
        
        zoomInButton.frame = CGRect(x: 680, y: 550, width: 30, height: 30)
        zoomOutButton.frame = CGRect(x: 710, y: 550, width: 30, height: 30)
        getHelpButton.frame = CGRect(x: 20, y: 20, width: 30, height: 30)
        
        zoomInButton.addTarget(self, action: #selector(zoom(_:)), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(zoom(_:)), for: .touchUpInside)
        getHelpButton.addTarget(self, action: #selector(showInstructionView(sender:)), for: .touchUpInside)
        self.view.addSubview(zoomInButton)
        self.view.addSubview(zoomOutButton)
        self.view.addSubview(getHelpButton)
    }
    
    //Creates gesture recognisers and adds to view
    func setupGestureRecognizers(){
        let swipeRightRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(sender:)))
        swipeRightRecogniser.direction = .right
        let swipeLeftRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(sender:)))
        swipeLeftRecogniser.direction = .left
        let swipeUpRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(sender:)))
        swipeUpRecogniser.direction = .up
        let swipeDownRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(sender:)))
        swipeDownRecogniser.direction = .down
        view.addGestureRecognizer(swipeRightRecogniser)
        view.addGestureRecognizer(swipeLeftRecogniser)
        view.addGestureRecognizer(swipeUpRecogniser)
        view.addGestureRecognizer(swipeDownRecogniser)
    }
    
    //Removes info views that may have been left in the view when shouldn't be
    func removeAllViews(){
        mercury.infoView.remove(from: self.sceneView)
        neptune.infoView.remove(from: self.sceneView)
        uranus.infoView.remove(from: self.sceneView)
        earth.infoView.remove(from: self.sceneView)
        mars.infoView.remove(from: self.sceneView)
        jupiter.infoView.remove(from: self.sceneView)
        saturn.infoView.remove(from: self.sceneView)
        venus.infoView.remove(from: self.sceneView)
    }
    
    
    //MARK: - Camera Movement Methods 
    
    //Animates camera fly over planets
    func runOpeningSequence(){
        inOpeningSequence = true
        let flyOverPlanets = SCNAction.move(to: SCNVector3Make(700, 300, 0), duration: 10)
        let moveToOverhead = SCNAction.move(to: SCNVector3Make(0, 6500, 0), duration: 5)
        let cameraToTopDown = SCNAction.rotateTo(x: CGFloat(-Float.pi/2.0), y: CGFloat.pi, z: 0, duration: 5)
        cameraNode.runAction(flyOverPlanets, completionHandler: {
            self.cameraNode.runAction(moveToOverhead, completionHandler: {
                self.rotatePlanetsAroundSun()
                self.inOpeningSequence = false
            })
            self.cameraNode.runAction(cameraToTopDown)
        })
    }
    
    //MARK: - Audio Methods
    
    //Plays background music within scene
    func startBackgroundMusic() {
        self.audioPlayer = AVAudioPlayer()
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: "PlanetSounds", ofType: "aif")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
        } catch let error as NSError {
            print("There was an error whilst trying to play: \(error.localizedDescription)")
        }
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        audioPlayer.numberOfLoops = 10
    }
    
    //MARK: - Animation Methods
    
    //Moves planets around the sun by calling the appropriate functions from the planet class
    func rotatePlanetsAroundSun(){
        mercury.animate(withTime: 60)
        venus.animate(withTime: 100)
        earth.animate(withTime: 150)
        mars.animate(withTime: 200)
        jupiter.animate(withTime: 250)
        saturn.animate(withTime: 300)
        uranus.animate(withTime: 350)
        neptune.animate(withTime: 400)
        planetsRotating = true
    }
    
    //Stops planets from rotating around the sun
    func stopRotationAroundSun(){
        planetsRotating = false
        mercury.node.removeAllActions()
        venus.node.removeAllActions()
        earth.node.removeAllActions()
        mars.node.removeAllActions()
        jupiter.node.removeAllActions()
        saturn.node.removeAllActions()
        uranus.node.removeAllActions()
        neptune.node.removeAllActions()
    }
    
    
    //MARK: - Button Actions
    
    //Changes the view based on user input from zoom buttons
    func zoom(_ sender: UIButton) {
        //Only allow zooming while currently on sun
        if currentPlanet == .Sun && !inOpeningSequence {
            if sender.tag == 1 {
                if inSideView && cameraNode.position.z < -1050 {
                    cameraNode.runAction(SCNAction.move(by: SCNVector3Make(0, 0, 100), duration: 0.5))
                } else if !inSideView && cameraNode.position.y > 800 {
                    cameraNode.runAction(SCNAction.move(by: SCNVector3Make(0, -100, 0), duration: 0.5))
                }
            } else {
                //Zoom out
                if inSideView && cameraNode.position.z > -3050 {
                    cameraNode.runAction(SCNAction.move(by: SCNVector3Make(0, 0, -100), duration: 0.5))
                } else if !inSideView && cameraNode.position.y < 7000 {
                    cameraNode.runAction(SCNAction.move(by: SCNVector3Make(0, 100, 0), duration: 0.5))
                }
            }
        }
    }

    //Show instruction view when user clicks (i) button on screen.
    func showInstructionView(sender: UIButton){
        instView.image = UIImage(named: "Instructions.png")
        instView.tag = 100
        instView.alpha = 0
        instView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let tapToDismiss = UILabel(frame: CGRect(x: 320, y: 340, width: 120, height: 30))
        tapToDismiss.text = "Tap to dismiss"
        tapToDismiss.font = UIFont(name: "CaviarDreams", size: 15)
        tapToDismiss.textColor = .white
        
        
        let dismissInstruction = UITapGestureRecognizer(target: self, action: #selector(handleTapInstructions(sender:)))
        view.addGestureRecognizer(dismissInstruction)
        instView.addSubview(tapToDismiss)
        sceneView.insertSubview(instView, at: 0)
        sceneView.bringSubview(toFront: instView)
        UIView.animate(withDuration: 0.5, animations: {
            self.instView.alpha = 1
        })
    }
    
    //MARK: - Gesture Recognizer methods
    
    //If instruction view is visible, dismiss when tapped
    func handleTapInstructions(sender: UITapGestureRecognizer?){
        if let v = view.viewWithTag(100) {
            UIView.animate(withDuration: 1, animations: {
                v.alpha = 0
            }, completion: { (didComplete) in
                v.removeFromSuperview()
            })
        }
    }
    
    //Deal with swipe gestures in different directions
    dynamic func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        if inOpeningSequence {
            return
        }
        handleTapInstructions(sender: nil)
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.up:
            inSideView = true
            currentPlanet = .Sun
            if !planetsRotating {
                rotatePlanetsAroundSun()
            }
            removeAllViews()
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(cameraNode.position.x, 120, -2750), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: CGFloat(0), y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            
        case UISwipeGestureRecognizerDirection.down:
            currentPlanet = .Sun
            if !planetsRotating {
                rotatePlanetsAroundSun()
            }
            removeAllViews()
            inSideView = false
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(0, 1500, 0), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: CGFloat(-Float.pi/2), y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            
        case UISwipeGestureRecognizerDirection.right:
            if let next = Planets(rawValue: currentPlanet.rawValue + 1){
                currentPlanet = next
            } else {
                currentPlanet = Planets(rawValue: 0)!
            }
            dealWithSwipe()
            
        case UISwipeGestureRecognizerDirection.left:
            if let next = Planets(rawValue: currentPlanet.rawValue - 1){
                currentPlanet = next
            } else {
                currentPlanet = Planets(rawValue: 8)!
            }
            dealWithSwipe()
        default:
            break
        }
    }
    
    //Deal with current planet change to change position of camera and rotation as necessary
    func dealWithSwipe(){
        switch currentPlanet {
        case .Sun:
            inSideView = false
            removeAllViews()
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(0, 1500, 0), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: CGFloat(-Float.pi/2), y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            if !planetsRotating {
                rotatePlanetsAroundSun()
            }
            break
            
        case .Mercury:
            stopRotationAroundSun()
            mercury.startSpin()
            venus.stopSpin()
            venus.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(mercury.node.position.x-17, mercury.node.position.y+10, mercury.node.position.z-50), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: -0.2, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            mercury.infoView.show(in: self.sceneView)
            break
            
        case .Venus:
            venus.startSpin()
            mercury.stopSpin()
            mercury.infoView.remove(from: self.sceneView)
            earth.stopSpin()
            earth.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(venus.node.position.x-25, venus.node.position.y+20, venus.node.position.z-100), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: -0.2, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            venus.infoView.show(in: self.sceneView)
            
        case .Earth:
            earth.startSpin()
            venus.stopSpin()
            venus.infoView.remove(from: self.sceneView)
            mars.stopSpin()
            mars.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(earth.node.position.x-25, earth.node.position.y+25, earth.node.position.z-100), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: -0.3, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            earth.infoView.show(in: self.sceneView)
            
        case .Mars:
            mars.startSpin()
            earth.stopSpin()
            earth.infoView.remove(from: self.sceneView)
            jupiter.stopSpin()
            jupiter.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(mars.node.position.x-17, mars.node.position.y+20, mars.node.position.z-60), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: -0.4, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            mars.infoView.show(in: self.sceneView)
            
        case .Jupiter:
            jupiter.startSpin()
            mars.stopSpin()
            mars.infoView.remove(from: self.sceneView)
            saturn.stopSpin()
            saturn.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(jupiter.node.position.x-200, jupiter.node.position.y+100, jupiter.node.position.z-900), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: -0.1, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            jupiter.infoView.show(in: self.sceneView)
            
        case .Saturn:
            saturn.startSpin()
            jupiter.stopSpin()
            jupiter.infoView.remove(from: self.sceneView)
            uranus.stopSpin()
            uranus.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(saturn.node.position.x-185, saturn.node.position.y+90, saturn.node.position.z-800), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: -0.1, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            saturn.infoView.show(in: self.sceneView)
            
        case .Uranus:
            uranus.startSpin()
            saturn.stopSpin()
            saturn.infoView.remove(from: self.sceneView)
            neptune.stopSpin()
            neptune.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(uranus.node.position.x-100, uranus.node.position.y+90, uranus.node.position.z-400), duration: 5))
            cameraNode.runAction(SCNAction.rotateTo(x: -0.2, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            uranus.infoView.show(in: self.sceneView)
            
        case .Neptune:
            neptune.startSpin()
            uranus.stopSpin()
            stopRotationAroundSun()
            uranus.infoView.remove(from: self.sceneView)
            cameraNode.runAction(SCNAction.rotateTo(x: -0.1, y: CGFloat(cameraNode.eulerAngles.y), z: CGFloat(cameraNode.eulerAngles.z), duration: 5))
            cameraNode.runAction(SCNAction.move(to: SCNVector3Make(neptune.node.position.x-100, neptune.node.position.y+70, neptune.node.position.z-400), duration: 5))
            neptune.infoView.show(in: self.sceneView)
        }
    }
}
