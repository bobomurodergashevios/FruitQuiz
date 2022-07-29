//
//  BananaVC.swift
//  FruitQuiz
//
//  Created by Bobomurod on 29/04/22.
//

import UIKit

class BananaVC: UIViewController {
    
    var quizFruits = [
        FruitsDM(sum1: 1, sum2: 5, variant: [3,4,5,6], answer: 6),
        FruitsDM(sum1: 4, sum2: 4, variant: [4,8,6,7], answer: 8),
        FruitsDM(sum1: 3, sum2: 3, variant: [6,4,8,9], answer: 6),
        FruitsDM(sum1: 2, sum2: 5, variant: [6,7,5,9], answer: 7),
        FruitsDM(sum1: 5, sum2: 3, variant: [2,8,4,5], answer: 8),
        FruitsDM(sum1: 1, sum2: 2, variant: [7,5,3,9], answer: 3),
        FruitsDM(sum1: 4, sum2: 1, variant: [3,5,7,9], answer: 5),
        FruitsDM(sum1: 3, sum2: 1, variant: [2,4,5,8], answer: 4),
        FruitsDM(sum1: 2, sum2: 2, variant: [3,4,5,8], answer: 4),
        FruitsDM(sum1: 1, sum2: 4, variant: [5,6,7,3], answer: 5)
    ]
    
    @IBOutlet var first_fruits_col: [UIImageView]!
    @IBOutlet var second_fruits_col: [UIImageView]!
    @IBOutlet var answerBtns: [UIButton]!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var current_ques_index:Int = 0
    var correct_answer_count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenImgView()
        setQuestion()
    }
    
    
    func hiddenImgView(){
        for img_1 in first_fruits_col{
            img_1.isHidden = true
        }
        
        for img_2 in second_fruits_col{
            img_2.isHidden = true
        }
    }
    
    func setQuestion(){
        quizFruits[current_ques_index].variant.shuffle()
        for i in 0..<quizFruits[current_ques_index].sum1{
            first_fruits_col[i].isHidden = false
        }
        
        for j in 0..<quizFruits[current_ques_index].sum2{
            second_fruits_col[j].isHidden = false
        }
        
        for btn in answerBtns.enumerated(){
            btn.element.setTitle(String(quizFruits[current_ques_index].variant[btn.offset]), for: .normal)
        }
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        if sender.currentTitle == String(quizFruits[current_ques_index].answer){
            correct_answer_count += 1
            sender.setTitleColor(UIColor.green, for: .normal)
        }else{
            sender.setTitleColor(UIColor.red, for: .normal)
        }
        
        for btn in answerBtns{
            btn.isEnabled = false
        }
    }
    @IBAction func nextTapped(_ sender: Any) {
        current_ques_index += 1
        if current_ques_index < quizFruits.count{
            hiddenImgView()
            setQuestion()
        }else{
            resultView.isHidden = false
            resultLabel.text = "\(correct_answer_count) / \(quizFruits.count)"
        }
        
        for btn in answerBtns{
            btn.isEnabled = true
            btn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        current_ques_index = 0
        correct_answer_count = 0
        resultView.isHidden = true
        quizFruits.shuffle()
        hiddenImgView()
        setQuestion()
    }
    
    @IBAction func hometapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
