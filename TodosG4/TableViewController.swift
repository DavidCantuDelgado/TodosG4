//
//  TableViewController.swift
//  TodosG4
//
//  Created by David A Cantú Delgado on 3/4/19.
//  Copyright © 2019 Tec de Monterrey. All rights reserved.
//

import UIKit

protocol ChangeStatusProtocol {
    func ChangeStatusTableVC(_ sender: TableViewCell)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var btState: UIButton!
    @IBOutlet weak var lbTask: UILabel!
    @IBOutlet weak var imCategory: UIImageView!
    
    var status: Bool!
    var delegate: ChangeStatusProtocol?
   
    
    @IBAction func ChangeStatus(_ sender: UIButton) {
    
        if status {
            btState.setImage(UIImage(named: "inprogress"), for: .normal)
            
        } else {
            btState.setImage(UIImage(named: "completed"), for: .normal)
        }
        status = !status
        delegate?.ChangeStatusTableVC(self)
    }
    
    
}


class TableViewController: UITableViewController, ChangeStatusProtocol {
    
    func ChangeStatusTableVC(_ sender: TableViewCell) {
        let indexPath = tableView.indexPath(for: sender)
        arrTasks[indexPath!.row].status = sender.status
    }
    

    var arrTasks = [Task]()
    var task: String!
    var category: String!
    var option : Bool!
    var currentRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrTasks.append(Task(task: "Hacer el Proyecto de Swift", category: "homework", status: false))
        arrTasks.append(Task(task: "Correr un 10K", category: "sports", status: false))
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        // TODO: Cambiar el número de secciones
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // TODO: Cambiar la cantidad de renglones en el TableView
        return arrTasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task cell", for: indexPath) as! TableViewCell

        // Configure the cell...
        // TODO: Definir lo que va en cada renglón
        cell.lbTask.text = arrTasks[indexPath.row].task
        
        cell.imCategory.image = UIImage(named: arrTasks[indexPath.row].category)
        
        if arrTasks[indexPath.row].status {
            cell.btState.setImage(UIImage(named: "completed"), for: .normal)
        } else {
            cell.btState.setImage(UIImage(named: "inprogress"), for: .normal)
        }
        
        cell.status = arrTasks[indexPath.row].status
        
        cell.delegate = self
    
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: Agregar funcionalidad para borrar un renglón
            arrTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        // TODO: Hacer lo necesario para cambiar los renglones de lugar
        
        var tempTask : Task
        tempTask = arrTasks[fromIndexPath.row]
        arrTasks[fromIndexPath.row] = arrTasks[to.row]
        arrTasks[to.row] = tempTask
        
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        // TODO: Crear el código para presentar la pantalla de detalle para agregar y editar
        
        if segue.identifier == "task edit" {
            let taskVC = segue.destination as! ViewController
            let indexPath = tableView.indexPathForSelectedRow
            taskVC.task = arrTasks[indexPath!.row].task
            taskVC.category = arrTasks[indexPath!.row].category
            taskVC.option = true
            currentRow = indexPath!.row
            //print(currentRow)
            
        } else {
            if segue.identifier == "task add" {
                let taskVC = segue.destination as! ViewController
                taskVC.option = false
                taskVC.task = ""
                taskVC.category = "homework"
                
            }
        }
        
        
    }
    
    @IBAction func SaveTask(unwind: UIStoryboardSegue) {
        if option {
            arrTasks[currentRow].task = task
            arrTasks[currentRow].category = category
        } else {
            arrTasks.append(Task(task: task, category: category, status: false))
        }
        tableView.reloadData()
    }
    

}
