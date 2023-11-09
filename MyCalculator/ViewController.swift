//
//  ViewController.swift
//  MyCalculator
//
//  Created by Marko Khomulyak on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {

    var firstNum: String = "";
    
    var operation: String = "";
    
    var secondNum: String = "";
    
    var haveResult: Bool = false;
    
    var resultNum: String = "";
    
    var numAfterResult: String = "";
    
    @IBOutlet weak var numOnScrean: UILabel!
    
    @IBOutlet var calcButtons: [UIButton]!
    
    @IBAction func numPressed(_ sender: UIButton) {
        if operation == "" {
            firstNum += String(sender.tag);
            numOnScrean.text = firstNum;
        }
        else if operation != "" && !haveResult {
            secondNum += String(sender.tag);
            numOnScrean.text = secondNum;
        }
        else if operation != "" && haveResult {
            numAfterResult += String(sender.tag);
            numOnScrean.text = numAfterResult;
        }
    }
    
    @IBAction func claer(_ sender: Any) {
        firstNum = "";
        operation = "";
        secondNum = "";
        haveResult = false;
        resultNum = "";
        numAfterResult = "";
        numOnScrean.text = "0";
    }
    
    @IBAction func add(_ sender: Any) {
        operation = "+";
    }
    
    @IBAction func subtract(_ sender: Any) {
        operation = "-";
    }
    
    @IBAction func multiply(_ sender: Any) {
        operation = "×";
    }
    
    @IBAction func divide(_ sender: Any) {
        operation = "/";
    }
    
    @IBAction func equals(_ sender: Any) {
        if let result = doOperation() {
            resultNum = String(result)
        } else {
            resultNum = "Cannot divide by zero"
        }
        numOnScrean.text = resultNum
        numAfterResult = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in calcButtons {
            button.layer.cornerRadius = button.frame.height / 2;
            button.titleLabel?.font = UIFont(name: "System", size: 24)
        }
    }
    
    func performOperation(operand1: Double?, operand2: Double?, operator: String) -> Double? {
        switch `operator` {
            case "+":
                return operand1.map { $0 + operand2! }
            case "-":
                return operand1.map { $0 - operand2! }
            case "×":
                return operand1.map { $0 * operand2! }
            case "/":
                if operand2 == 0 {
                    return nil
                }
                return operand1.map { $0 / operand2! }
            default:
                return nil
            }
        }

        func doOperation() -> Double? {
            if operation.isEmpty {
                return nil
            }
        
            if !haveResult {
                haveResult = true
                return performOperation(operand1: Double(firstNum), operand2: Double(secondNum), operator: operation)
            } else {
                return performOperation(operand1: Double(resultNum), operand2: Double(numAfterResult), operator: operation)
            }
        }

}
