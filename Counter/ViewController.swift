//
//  ViewController.swift
//  Counter
//
//  Created by Victor on 18.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterScoreLabel: UILabel!
    @IBOutlet weak var changeLogTextView: UITextView!
    
    //Перечисление для формирования истории изменений в логе
    private enum transactionsTypes {
        case plus,
             minus,
             erase,
             decreaseZero,
             undefined
    }
    
    //Переменная для хранения текущей операции
    private var currentTransaction: transactionsTypes = .undefined
    
    private var counter: Int = 0 {
        didSet{
            counterScoreLabel.text = "Значение счетчика:\n\(counter)"
            saveActionInLog()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.changeLogTextView.layoutManager.allowsNonContiguousLayout = false
    }

    //Метод для увеличения значения счетчика
    @IBAction func increaseButtonTapped(_ sender: UIButton) {
        currentTransaction = .plus
        counter += 1
    }
    
    //Метод для уменьшения значения счетчика
    @IBAction func decreaseButtonTapped(_ sender: UIButton) {
        if counter >= 1 {
            currentTransaction = .minus
            counter -= 1
        } else {
            currentTransaction = .decreaseZero
            saveActionInLog()
        }
    }
    
    //Метод для обнуления значения счетчика
    @IBAction func eraseCurrentScore(_ sender: UIButton) {
        currentTransaction = .erase
        counter = 0
    }
    
    //Метод для регистрации изменений в логе
    private func saveActionInLog() {
        switch currentTransaction {
        case .erase:
            changeLogTextView.text += "\nзначение сброшено"
        case .minus:
            changeLogTextView.text += "\nзначение изменено на -1"
        case .plus:
            changeLogTextView.text += "\nзначение изменено на +1 "
        case .decreaseZero:
            changeLogTextView.text += "\nпопытка уменьшить значение счётчика ниже 0"
        case .undefined:
            return
        }

        //Если лог уже занимает больше места чем высота поля для ввода лога, то скроллим лог
        if changeLogTextView.contentSize.height > changeLogTextView.frame.size.height {
            changeLogTextView.setContentOffset(CGPoint(x: 0, y: changeLogTextView.contentSize.height - changeLogTextView.frame.size.height), animated: true)
        }
    }
}

