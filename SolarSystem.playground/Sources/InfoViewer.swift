import SceneKit
import UIKit

/*
 InfoViewer.swift
 
    * Used to display the data for each planet
 
*/

public class InfoViewer: UIView {
    //MARK: - Attribute Declarations
    var planetName: String
    var planetMass: Double
    var planetDiameter: Double
    var lengthOfDay: Double
    var distanceFromSun: Double
    var temperature: Double
    var titleLabel = UILabel()
    var massLabel = UILabel()
    var diameterLabel = UILabel()
    var dayLengthLabel = UILabel()
    var sunDistanceLabel = UILabel()
    var tempLabel = UILabel()
    
    //MARK: - Initialiser
    init(planetName: String, planetMass: Double, planetDiameter: Double, lengthOfDay: Double, distanceFromSun: Double, temperature: Double){
        let cdURL = Bundle.main.url(forResource: "CaviarDreams", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cdURL, CTFontManagerScope.process, nil)
        let cdBoldURL = Bundle.main.url(forResource: "CaviarDreams_Bold", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cdBoldURL, CTFontManagerScope.process, nil)
        
        self.planetName = planetName
        self.planetMass = planetMass
        self.planetDiameter = planetDiameter
        self.lengthOfDay = lengthOfDay
        self.distanceFromSun = distanceFromSun
        self.temperature = temperature
        
        
        super.init(frame: CGRect(x: 470, y: 50, width: 250, height: 500))
        self.backgroundColor = .black
        self.layer.cornerRadius = 12
        self.alpha = 0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 5
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    //MARK: - Label Generation
    private func generateLabel(font: String, pos: CGRect, text: String, size: CGFloat, allignment: NSTextAlignment) -> UILabel{
        let label = UILabel(frame: pos)
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = .white
        label.numberOfLines = 2
        label.alpha = 0
        label.textAlignment = allignment
        return label
    }
    
    
    //MARK: - Show and Remove viewer
    
    //Create and show the information view as a subview of a given view
    func show(in view: UIView){
        titleLabel = generateLabel(font: "CaviarDreams-Bold", pos: CGRect(x: 470, y: 80, width: 250, height: 40), text: planetName, size: 42, allignment: .center)
        massLabel = generateLabel(font: "CaviarDreams", pos: CGRect(x: 470, y: 150, width: 250, height: 60), text: "Mass:\n \(planetMass) x 10^24 kg", size: 22, allignment: .center)
        diameterLabel = generateLabel(font: "CaviarDreams", pos: CGRect(x: 470, y: 225, width: 250, height: 60), text: "Diameter:\n \(planetDiameter)km", size: 22, allignment: .center)
        dayLengthLabel = generateLabel(font: "CaviarDreams", pos: CGRect(x: 470, y: 300, width: 250, height: 60), text: "Length of one day:\n \(lengthOfDay) hours", size: 22, allignment: .center)
        sunDistanceLabel = generateLabel(font: "CaviarDreams", pos: CGRect(x: 470, y: 375, width: 250, height: 60), text: "Distance from the sun:\n \(distanceFromSun) x 10^6 km", size: 22, allignment: .center)
        tempLabel = generateLabel(font: "CaviarDreams", pos: CGRect(x: 470, y: 450, width: 250, height: 60), text: "Mean Temperature:\n \(temperature)°C", size: 22, allignment: .center)
        view.addSubview(self)
        view.addSubview(titleLabel)
        view.addSubview(massLabel)
        view.addSubview(diameterLabel)
        view.addSubview(dayLengthLabel)
        view.addSubview(sunDistanceLabel)
        view.addSubview(tempLabel)
        UIView.animate(withDuration: 2, delay: 6.0, options: .curveEaseInOut, animations: {
            self.alpha = 1
            self.titleLabel.alpha = 1
            self.massLabel.alpha = 1
            self.diameterLabel.alpha = 1
            self.dayLengthLabel.alpha = 1
            self.sunDistanceLabel.alpha = 1
            self.tempLabel.alpha = 1
        }, completion: nil)
    }
    
    //Remove the information view from the given view
    func remove(from view: UIView){
        UIView.animate(withDuration: 2, delay: 0.0, options: .curveEaseInOut, animations: {
            self.alpha = 0
            self.titleLabel.alpha = 0
            self.massLabel.alpha = 0
            self.diameterLabel.alpha = 0
            self.dayLengthLabel.alpha = 0
            self.sunDistanceLabel.alpha = 0
            self.tempLabel.alpha = 0
        }, completion: {(completed) in
            self.removeFromSuperview()
            self.titleLabel.removeFromSuperview()
            self.massLabel.removeFromSuperview()
            self.diameterLabel.removeFromSuperview()
            self.dayLengthLabel.removeFromSuperview()
            self.sunDistanceLabel.removeFromSuperview()
            self.tempLabel.removeFromSuperview()
        })
    }
    
    

}
