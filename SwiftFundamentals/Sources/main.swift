// The Swift Programming Language
// https://docs.swift.org/swift-book

// Initialize Swift console app
// swift package init --type executable
// Run with arguments
// swift run SwiftFundamentals 1 2 +
// Build to make it as system executable program
// swift build --configuration release
// cp -f .build/release/ExampleApp /usr/local/bin/ExampleApp


 import ArgumentParser
/*
 struct ReadPreference: ParsableCommand {
 public static let configuration = CommandConfiguration(abstract: "Tinh toan +, -, *, /")
 
 @Argument(help: "So thu 1")
 private var so1: Double
 
 @Argument(help: "So thu 2")
 private var so2: Double
 
 @Argument(help: "Phep tinh")
 private var phepTinh: String
 
 func run() throws {
 switch phepTinh {
 case "+":
 print("Ket qua: \(self.phepCong())")
 case "-":
 print("Ket qua: \(self.phepTru())")
 case "*":
 print("Ket qua: \(self.phepNhan())")
 case "/":
 print("Ket qua: \(self.phepChia())")
 default:
 print("Chuong trinh chua ho tro")
 }
 
 // 1. Variables
 var myVariable = 42
 myVariable = 50
 let myConstant = 42
 
 print("myVariable: \(myVariable)")
 print("myConstant: \(myConstant)")
 
 let implicitInteger = 70
 let implicitDouble = 70.0
 let explicitDouble: Double = 70
 
 print("myVariable: \(myVariable)")
 print("myConstant: \(myConstant)")
 }
 
 func phepCong() -> Double {
 return so1 + so2
 }
 
 func phepTru() -> Double {
 return so1 - so2
 }
 
 func phepNhan() -> Double {
 return so1 * so2
 }
 
 func phepChia() -> Double {
 return so1 / so2
 }
 }
 
 //print("Hello, world!")
 ReadPreference.main()
 
 */

struct MainProgram: ParsableCommand {
    func run() throws {
        // 1. Variables
        var myVariable = 42
        myVariable = 50
        let myConstant = 42
        
        print("myVariable: \(myVariable)")
        print("myConstant: \(myConstant)")
        
        let implicitInteger = 70
        let implicitDouble = 70.0
        let explicitDouble: Double = 70
        
        print("myVariable: \(implicitInteger)")
        print("myConstant: \(implicitDouble)")
        print("explicitDouble: \(explicitDouble)")
        
        let label = "The width is "
        let width = 94
        let widthLabel = label + String(width)
        
        print("widthLabel: \(widthLabel)")
        
        let apples = 3
        let oranges = 5
        let appleSummary = "I have \(apples) apples."
        let fruitSummary = "I have \(apples + oranges) pieces of fruit."
        
        print("appleSummary: \(appleSummary)")
        print("fruitSummary: \(fruitSummary)")
        
        let quotation = """
            Even though there's whitespace to the left,
            the actual lines aren't indented.
                Except for this line.
            Double quotes (") can appear without being escaped.
            
            I still have \(apples + oranges) pieces of fruit.
            """
        
        print("quotation: \n\(quotation)")
        
        var fruits = ["strawberries", "limes", "tangerines"]
        fruits[1] = "grapes"
        fruits.append("blueberries")
        
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
        ]
        
        occupations["Jayne"] = "Public Relations"
        print("fruits: \(fruits)")
        
        fruits = []
        occupations = [:]
        
        let emptyArray: [String] = []
        let emptyDictionary: [String: Float] = [:]
        
        print("emptyArray: \(emptyArray)")
        print("emptyDictionary: \(emptyDictionary)")
        
        // 2. Control Flow
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
        }
        print("teamScore: \(teamScore)")
        
        let scoreDecoration = if teamScore > 10 {
            "🎉"
        } else {
            ""
        }
        print("scoreDecoration: \(scoreDecoration)")
        
        var optionalString: String? = "Hello"
        print("optionalString == nil: \(optionalString == nil)")
        
        var optionalName: String? = "John Appleseed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        print("greeting: \(greeting)")
        
        let nickname: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeing = "Hi \(nickname ?? fullName)"
        
        if let nickname {
            print("Hey, \(nickname)")
        }
        
        let vegetable = "red pepper"
        switch vegetable {
            case "celery":
                print("Add some raisins and make ants on a log.")
            case "cucumber", "watercress":
                print("That would make a good tea sandwich.")
            case let x where x.hasPrefix("pepper"):
                print("Is it spicy? \(x)")
            default:
                print("Everything tastes good in soup.")
        }
        
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        
        var largest = 0
        for (_, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        
        print("largest: \(largest)")
        
        var n = 2
        while n < 100 {
            n *= 2
        }
        print("n: \(n)")
        
        var m = 2
        repeat {
            m *= 2
        } while m < 100
        print("m: \(m)")
        
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print("total: \(total)")
    }
}

MainProgram.main()
