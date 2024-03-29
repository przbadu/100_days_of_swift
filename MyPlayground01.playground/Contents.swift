import Cocoa

////struct Employee {
////    let name: String
////    var vacationAllocated = 14
////    var vaccationTaken = 0
////    
////    var vaccationRemaining: Int {
////        get {
////            vacationAllocated - vaccationTaken
////        }
////        
////        set {
////            vacationAllocated = vaccationTaken + newValue
////        }
////    }
////}
////
////var bob = Employee(name: "Bob")
////bob.vaccationTaken += 4
////bob.vaccationRemaining = 5
////print("Taken: \(bob.vaccationTaken), remaining: \(bob.vacationAllocated)")
//
//enum GearMode { case up, down}
//
//struct Car {
//    var model: String
//    var numberOfSeats: Int
//    private(set) var currentGear: Int
//    
//    mutating func changeGear(to: GearMode) {
//        switch to {
//        case .up:
//            currentGear += 1
//        default:
//            currentGear -= 1
//        }
//        
//        if currentGear <= 0 {
//            currentGear = 0
//        } else if currentGear >= 5 {
//            currentGear = 5
//        }
//    }
//}
//
//var ioniq = Car(model: "Hyundai Ioniq 5", numberOfSeats: 5, currentGear: 0)
//print(ioniq.currentGear)
//ioniq.changeGear(to: GearMode.up)
//print(ioniq.currentGear)
//ioniq.changeGear(to: GearMode.up)
//print(ioniq.currentGear)
//ioniq.changeGear(to: GearMode.down)
//print(ioniq.currentGear)
//ioniq.changeGear(to: GearMode.down)
//ioniq.changeGear(to: GearMode.down)
//ioniq.changeGear(to: GearMode.down)
//ioniq.changeGear(to: GearMode.down)
//print(ioniq.currentGear)
//ioniq.changeGear(to: GearMode.up)
//ioniq.changeGear(to: GearMode.up)
//ioniq.changeGear(to: GearMode.up)
//print(ioniq.currentGear)
//ioniq.changeGear(to: GearMode.up)
//ioniq.changeGear(to: GearMode.up)
//ioniq.changeGear(to: GearMode.up)
//print(ioniq.currentGear)
//

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I am travelling \(distance)km.")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 5
    }
    
    func travel(distance: Int) {
        print("I am travelling \(distance)km in bicycle.")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("Tat's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): Estimated time to travel \(distance)km is \(estimate)")
    }
}


let car = Car()
commute(distance: 150, using: car)

let bicycle = Bicycle()
commute(distance: 50, using: bicycle)

getTravelEstimates(using: [car, bicycle], distance: 400)


///
/// Extensions
///
var quote = "  The truth is rarely pure and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

print(trimmed)
print(quote)

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed()
    }
    
    // computed properties in extension
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
    
    var joins: [String] {
        self.components(separatedBy: ", ")
    }
}

print(quote.trimmed())

print ("  ")
print (quote)
quote.trim() // modify the string same as ! sign in ruby
print (quote)

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)
print(lyrics.lines)
print(lyrics.joins)

///
/// Equatable and Comparable
///
struct User: Comparable {
    let name: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
}

let taylor = User(name: "Taylor")
let adele = User(name: "Adele")

print(taylor == adele)
print(taylor > adele)
print(taylor < adele)
print(taylor >= adele)
print(taylor <= adele)


protocol Building {
    var numberOfRooms: Int { get set }
    var cost: Int { get set }
    var name: String { get set }
    func summary()
}

struct House: Building {
    var numberOfRooms: Int
    var cost: Int
    var name: String
}

struct Office: Building {
    var numberOfRooms: Int
    var cost: Int
    var name: String
}

extension Building {
    func summary() {
        print("\(name) owns a house with \(numberOfRooms) rooms that costs $\(cost)")
    }
}

var house = House(numberOfRooms: 5, cost: 200000, name: "John Doe")
var office = Office(numberOfRooms: 2, cost: 12000, name: "Przbadu")

print(house.summary())
print(office.summary())


///
/// Optionals
///
func optionalWithUnwrapped(_ number: Int?) {
    if let number = number {
        print("[Unwrapped] Number is \(number)")
    }
}

func optionalWithGuard(_ number: Int?) {
    guard let number = number else {
        print("[Guard] Number is missing")
        return
    }
    
    print("[Guard] Number is \(number)")
}

optionalWithGuard(1)
optionalWithUnwrapped(2)
optionalWithGuard(nil)
optionalWithUnwrapped(nil)
