//
//  ViewController.swift
//  Counter
//
//  Created by Victor on 18.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var counterScoreLabel: UILabel!
    @IBOutlet private weak var changeLogTextView: UITextView!
    
    //Перечисление для формирования истории изменений в логе
    private enum TransactionType {
        case plus,
             minus,
             erase,
             decreaseZero,
             undefined
    }
    
    //Переменная для хранения текущей операции
    private var currentTransaction: TransactionType = .undefined
    
    private var counter: Int = 0 {
        didSet{
            counterScoreLabel.text = "Значение счетчика:\n\(counter)"
            saveActionInLog()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLogTextView.layoutManager.allowsNonContiguousLayout = false
    }

    //Метод для увеличения значения счетчика
    @IBAction private func increaseButtonTapped(_ sender: UIButton) {
        currentTransaction = .plus
        counter += 1
    }
    
    //Метод для уменьшения значения счетчика
    @IBAction private func decreaseButtonTapped(_ sender: UIButton) {
        if counter >= 1 {
            currentTransaction = .minus
            counter -= 1
        } else {
            currentTransaction = .decreaseZero
            counter += 0
        }
    }
    
    //Метод для обнуления значения счетчика
    @IBAction private func eraseCurrentScore(_ sender: UIButton) {
        currentTransaction = .erase
        counter = 0
    }
    
    //Метод для регистрации изменений в логе
    private func saveActionInLog() {
        //Константа для хранения форматтера даты времени
        let formatter = DateFormatter()
        formatter.dateFormat = "[dd.MM.yyyy HH:mm:ss]:"
       
        
        switch currentTransaction {
        case .erase:
            changeLogTextView.text += "\n" + formatter.string(from: Date()) + " значение сброшено"
        case .minus:
            changeLogTextView.text += "\n" + formatter.string(from: Date()) + " значение изменено на -1"
        case .plus:
            changeLogTextView.text += "\n" + formatter.string(from: Date()) + " значение изменено на +1 "
        case .decreaseZero:
            changeLogTextView.text += "\n" + formatter.string(from: Date()) + " попытка уменьшить значение счётчика ниже 0"
        case .undefined:
            return
        }

        //Если высота лога больше чем высота поля для ввода лога, то скроллим лог
        if changeLogTextView.contentSize.height > changeLogTextView.frame.size.height {
            changeLogTextView.setContentOffset(CGPoint(x: 0, y: changeLogTextView.contentSize.height - changeLogTextView.frame.size.height), animated: true)
        }
    }
}

