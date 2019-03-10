//
//  ViewController.swift
//  TodosG4
//
//  Created by David A Cantú Delgado on 3/4/19.
//  Copyright © 2019 Tec de Monterrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var task: String!
    var category: String!
    var option: Bool!
    
    @IBOutlet weak var tfTask: UITextField!
    @IBOutlet weak var scCategory: UISegmentedControl!
    @IBOutlet weak var imCategory: UIImageView!
    @IBOutlet weak var btSave: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if option {
            tfTask.text = task
            imCategory.image = UIImage(named: category)
            switch category {
            case "homework":
                scCategory.selectedSegmentIndex = 0
            case "exam":
                scCategory.selectedSegmentIndex = 1
            case "friends":
                scCategory.selectedSegmentIndex = 2
            case "sports":
                scCategory.selectedSegmentIndex = 3
            default:
                scCategory.selectedSegmentIndex = 0
            }
        } else {
            tfTask.text = task
            imCategory.image = UIImage(named: category)
            scCategory.selectedSegmentIndex = 0
        }
    }

    @IBAction func ChangeImage(_ sender: UISegmentedControl) {
        switch scCategory.selectedSegmentIndex {
        case 0:
            imCategory.image = UIImage(named: "homework")
        case 1:
            imCategory.image = UIImage(named: "exam")
        case 2:
            imCategory.image = UIImage(named: "friends")
        case 3:
            imCategory.image = UIImage(named: "sports")
        default:
            imCategory.image = UIImage(named: "homework")

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let btn = sender as! UIBarButtonItem
        
        if btn == btSave {
            let tableVC = segue.destination as! TableViewController
            tableVC.task = tfTask.text
            switch scCategory.selectedSegmentIndex {
            case 0:
                tableVC.category = "homework"
            case 1:
                tableVC.category = "exam"
            case 2:
                tableVC.category = "friends"
            case 3:
                tableVC.category = "sports"
            default:
                tableVC.category = "homework"

            }
            tableVC.option = option
            
            
        }
    }
    
    
}

