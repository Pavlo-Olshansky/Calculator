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
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var displayResultLabel: UILabel!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        print(number)
        
        if displayResultLabel.text?.count ?? 0 < 20 {
            displayResultLabel.text = displayResultLabel.text! + number
        }
    }
}

