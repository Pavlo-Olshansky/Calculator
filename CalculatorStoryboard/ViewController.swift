//
//  ViewController.swift
//  CalculatorStoryboard
//
//  Created by Pavlo Olshansky on 10/14/19.
//  Copyright © 2019 Pavlo Olshansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayConnectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var dotIsPlaced = false

    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.split(separator: ".")
            if valueArray[1] == "0" {
                displayResultLabel.text = "\(valueArray[0])"
            } else {
                displayResultLabel.text = value
            }
            stillTyping = false
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if stillTyping {
            let firstZero = displayResultLabel.text == "0" && number == "0"
            if displayResultLabel.text?.count ?? 0 < 20 && !firstZero {
                displayResultLabel.text = displayResultLabel.text! + number
                displayResultLabel.contentMode = .center
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
            
        }
    }

    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }

    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "✕":
            operateWithTwoOperands{$0 * $1}
        case "∕":
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }

    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlaced = false
    }

    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        print(firstOperand)
        print(secondOperand)
        print(currentInput)
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
            currentInput = secondOperand
        }
    }

    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }

    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLabel.text = "0."
            stillTyping = true
        }
    }
}

