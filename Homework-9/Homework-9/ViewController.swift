//
//  ViewController.swift
//  Homework-9
//
//  Created by Миша Кацуро on 25.06.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBAction func mainButton(_ sender: UIButton) {
        let mains = self.storyboard?.instantiateViewController (withIdentifier:
        "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(mains, animated: true)
    }
    @IBAction func otherButton(_ sender: UIButton) {
        let others = self.storyboard?.instantiateViewController (withIdentifier:
        "ThirdViewController") as! ThirdViewController
        self.navigationController?.pushViewController(others, animated: true)
        
    }
    
    @IBAction func thirdTaskButton(_ sender: UIButton) {
        let thirdTask = self.storyboard?.instantiateViewController (withIdentifier:
        "ThirdTaskViewController") as! ThirdTaskViewController
        self.navigationController?.pushViewController(thirdTask, animated: true)
        
    }
    @IBOutlet weak var firstImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

