//
//  ViewController.swift
//  Calculator_BTU_8
//
//  Created by Nika Topuria on 29.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    var displayValue: String = "0" {
        didSet {
                resultValue.text = displayValue
        }
    }
    
    var inputNumbers: String = "" {
        didSet {
            if inputNumbers == "" {
                displayValue = "0"
            } else {
                displayValue = inputNumbers
            }
        }
    }

    // Placeholders for operands
    var equalsWasPressed: Bool = false
    var variableA: Double?
    var variableB: Double?
    var sign: String = ""
    
    
    
    @IBOutlet var resultValue: UILabel!
    
    @IBAction func basicOperators(_ sender: UIButton) {
        // Keep track of first and second variables of operation

        if variableA == nil {
            print ("Set variable A")
            variableA = Double(displayValue) ?? 11111111
            inputNumbers = ""
            displayValue = removeZerosFromEnd(String(variableA!))
        } else if variableA != nil && variableB == nil {
            print ("Set variable B")
            variableB = Double(displayValue) ?? 11111111
            print ("Calculating: \(self.variableA!) \(sign) \(self.variableB!)")
            let tempResult = calculate(self.variableA!, self.variableB!, sign)
            inputNumbers = ""
            displayValue = removeZerosFromEnd(String(tempResult))
            print(tempResult)
            variableA = tempResult
            variableB = nil
        }
        sign = sender.currentTitle!
    }
    
    // Does basic calculation
    func calculate(_ a: Double, _ b: Double, _ sign: String) -> Double {
        switch sign {
        case "÷":
            return a/b
        case "×":
            return a*b
        case "-":
            return a-b
        case "+":
            return a+b
        default:
            print ("Default action for basic operators")
        }
        return 0
    }
    
    // Manages number input
    @IBAction func blueButtons(_ sender: UIButton) {
        if equalsWasPressed == true {
            inputNumbers = ""
            equalsWasPressed = false
        }
        // Check if "." has been used in current input and prevent further "."-s
        if sender.currentTitle! == "." && !inputNumbers.contains(".") {
            inputNumbers += sender.currentTitle!
        } else if sender.currentTitle! != "."{
            inputNumbers += sender.currentTitle!
        }
    }
    
    
    // Manages "=" button press
    @IBAction func equalsButton(_ sender: UIButton) {
        if variableA != nil && variableB == nil {
            print ("Set variable B")
            variableB = Double(displayValue) ?? 11111111
            print ("Calculating: \(self.variableA!) \(sign) \(self.variableB!)")
            let tempResult = calculate(self.variableA!, self.variableB!, sign)
        //    inputNumbers = ""
            displayValue = removeZerosFromEnd(String(tempResult))
            print(tempResult)
            variableA = nil
            variableB = nil
            sign = ""
        }
        equalsWasPressed = true
    }
    
    
    // Defines actions for every gray button pressed
    @IBAction func grayButtons(_ sender: UIButton) {
        switch sender.currentTitle {
        case "%":
            let answer = String((Double(inputNumbers) ?? 0000000) / Double(100))
            print (answer)
            inputNumbers = answer
        case "+/-":
            let answer: String
            if !inputNumbers.contains(".") {
                answer = String(-(Int(inputNumbers) ?? 111111111))
            } else {
                answer = String(-(Double(inputNumbers) ?? 111111111))
            }
            print (answer)
            inputNumbers = answer
        case "AC":
            inputNumbers = ""
            variableA = nil
            variableB = nil
            sign = ""
            
        default:
            print("Default for switch statement")
        }
    }
    
    
    //My modest implementation to remove trailing zeros from doubles
    func removeZerosFromEnd(_ result: String) -> String {
        var finalResult = result
        if result.contains(".") {
            let tempString = String(result.reversed())
            for char in tempString{
                if char == "0"{
                    finalResult.removeLast()
                } else if char == "."{
                    finalResult.removeLast()
                    break
                } else {
                    break
                }
            }
        }
        return finalResult
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultValue.text = String(displayValue)
    }

}


