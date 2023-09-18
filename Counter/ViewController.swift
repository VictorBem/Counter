//
//  ViewController.swift
//  Counter
//
//  Created by Victor on 18.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterScoreLabel: UILabel!
    
    private var counter: Int = 0 {
        didSet{
            counterScoreLabel.text = "Значение счетчика:\n/(counter)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Метод для обработки нажания на кнопку увеличения счетчика
    @IBAction func increaseButtonTapped(_ sender: UIButton) {
        counter += 1
    }
    
    //Метод для обработки нажания на кнопку уменьшения счетчика
    @IBAction func decreaseButtonTapped(_ sender: UIButton) {
        if counter >= 1 {
            counter -= 1
        }
    }
    
}

