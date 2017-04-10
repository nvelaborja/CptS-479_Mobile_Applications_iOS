//
//  JokeTableViewController.swift
//  Joker
//
//  Created by Nathan VelaBorja on 2/13/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import UIKit

class JokeTableViewController: UITableViewController {
    
    var jokes: JokeArray = JokeArray()
    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jokes.jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = jokes.jokes[indexPath.row].firstLine

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Remove joke from database
            let jokeToDelete = jokes.jokes[indexPath.row]
            appDelegate.deleteJoke(jokeToDelete.firstLine, jokeToDelete.secondLine, jokeToDelete.thirdLine, jokeToDelete.answerLine)
            
            // Delete the row from the data source
            jokes.jokes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editJoke", sender: jokes.jokes[indexPath.row])
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editJoke") {
            let view = segue.destination as! ViewEditJokeViewController
            let joke = (sender as! Joke)
            view.oldLine1 = joke.firstLine
            view.oldLine2 = joke.secondLine
            view.oldLine3 = joke.thirdLine
            view.oldAnswer = joke.answerLine
        }
    }
    
    @IBAction func unwindFromDetail (segue: UIStoryboardSegue) {
        if (segue.identifier == "unwindFromAddJoke") {
            let addVC = segue.source as! AddJokeViewController
            if (addVC.savePressed) {
                let newJoke = Joke(addVC.Line1TextField.text!, addVC.Line2TextField.text!, addVC.Line3TextField.text!, addVC.AnswerTextField.text!)
                
                // Don't accept the joke if the whole thing is blank
                if (newJoke.answerLine == "" && newJoke.firstLine == "" && newJoke.secondLine == "" && newJoke.thirdLine == "") {
                    return
                }
                
                jokes.add(newJoke)
                
                // Add joke to database
                appDelegate.addJoke(newJoke.firstLine, newJoke.secondLine, newJoke.thirdLine, newJoke.answerLine)
            
                self.tableView.reloadData()
            }
        }
        
        if (segue.identifier == "unwindFromEditJoke") {
            let editVC = segue.source as! ViewEditJokeViewController
            if (editVC.save) {
                // Edit joke in database
                appDelegate.editJoke(editVC.oldLine1, editVC.oldLine2, editVC.oldLine3, editVC.oldAnswer, editVC.line1.text!, editVC.line2.text!, editVC.line3.text!, editVC.answer.text!)
                
                // Reload data source
                self.jokes = JokeArray(appDelegate.getJokeObjects())
                
                // Reload table view
                self.tableView.reloadData()
            }
        }
    }
    
//    @IBAction func unwindFromAddJokeView (sender: UIStoryboardSegue) {
//        let addJokeViewController = sender.source as! AddJokeViewController
//        
//        addJoke(addJokeViewController.Line1TextField.text!, addJokeViewController.Line2TextField.text!, addJokeViewController.Line3TextField.text!, addJokeViewController.AnswerTextField.text!)
//    }

}
