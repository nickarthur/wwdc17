import SceneKit
import UIKit

/* 
 PlanetData.swift
 
    * Stores commonly used structures and enums for the planets.
    * Also contains all relevant data for each planet, as well as instances of the Planet and Star class for their relevant objects.
 
*/

//Information given for each plan
public struct planetInfo {
    var mass = 0.0
    var diameter = 0.0
    var lengthOfDay = 0.0
    var distanceFromSun = 0.0
    var temperature = 0.0
}

//Enum used to iterate through the planets
enum Planets: Int {
    case Sun = 0
    case Mercury = 1
    case Venus = 2
    case Earth = 3
    case Mars = 4
    case Jupiter = 5
    case Saturn = 6
    case Uranus = 7
    case Neptune = 8
}

//Planet Data to display on InfoViewers
let mercuryData = planetInfo(mass: 0.330, diameter: 4879, lengthOfDay: 4222.6, distanceFromSun: 59.7, temperature: 167)
let venusData = planetInfo(mass: 4.87, diameter: 12104, lengthOfDay: 2802, distanceFromSun: 108.2, temperature: 464)
let earthData = planetInfo(mass: 5.97, diameter: 12756, lengthOfDay: 24, distanceFromSun: 149.6, temperature: 15)
let marsData = planetInfo(mass: 0.642, diameter: 6792, lengthOfDay: 708.7, distanceFromSun: 227.9, temperature: -65)
let jupiterData = planetInfo(mass: 1898, diameter: 142984, lengthOfDay: 9.9, distanceFromSun: 778.6, temperature: -110)
let saturnData = planetInfo(mass: 568, diameter: 120536, lengthOfDay: 10.7, distanceFromSun: 1433.5, temperature: -140)
let uranusData = planetInfo(mass: 86.8, diameter: 51118, lengthOfDay: 17.2, distanceFromSun: 2872.5, temperature: -195)
let neptuneData = planetInfo(mass: 102, diameter: 49528, lengthOfDay: 16.1, distanceFromSun: 4495.1, temperature: -200)

//Planets contained within the solar system
let sun = Star(name: "Sun", image: UIImage(named: "2k_sun.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 400, distanceFromCentre: 0)
let mercury = Planet(planetName: "Mercury", image: UIImage(named:"2k_mercury.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 9.5, distanceFromCentre: 600, planetInfo: mercuryData)
let venus = Planet(planetName: "Venus", image: UIImage(named:"2k_venus_surface.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 23.75, distanceFromCentre: 700, planetInfo: venusData)
let earth = Planet(planetName: "Earth", image: UIImage(named:"2k_earth_daymap.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 25, distanceFromCentre: 800, planetInfo: earthData)
let mars = Planet(planetName: "Mars", image: UIImage(named: "2k_mars.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 13.25, distanceFromCentre: 900, planetInfo: marsData)
let jupiter = Planet(planetName: "Jupiter", image: UIImage(named: "2k_jupiter.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 280.0, distanceFromCentre: 1300, planetInfo: jupiterData)
let saturn = Planet(planetName: "Saturn", image: UIImage(named: "2k_saturn.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 236.25, distanceFromCentre: 2250, planetInfo: saturnData)
let uranus = Planet(planetName: "Uranus", image: UIImage(named: "2k_uranus.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 100.0, distanceFromCentre: 3000, planetInfo: uranusData)
let neptune = Planet(planetName: "Neptune", image: UIImage(named: "2k_neptune.jpg", in: Bundle.main, compatibleWith: nil)!, radius: 97.0, distanceFromCentre: 3500, planetInfo: mercuryData)
