//
//  MasterViewController.swift
//  flowers
//
//  Created by Sanjay Mallik on 11/28/14.
//  Copyright (c) 2014 Sanjay Mallik. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = NSMutableArray()
    
    var waterfallViewController: NTWaterfallViewController? = nil
    
    var items: [String] = ["Flower1", "FLower2", "Flower3"]
    var itemDesc: [String] = ["Flower1", "Flower2", "Flower3"]
    var imageList: [UIImage] = [UIImage(named: "Icon-72")!, UIImage(named: "Image006")!, UIImage(named: "Icon-76")!]
    


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        /*
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }*/

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            /*if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as NSDate
            (segue.destinationViewController as DetailViewController).detailItem = object
            }*/
            (segue.destinationViewController as? NTWaterfallViewController)//.detailItem = object

        }
    }

    // MARK: - Table View
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count //objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell
        //self.configureCell(cell, atIndexPath: indexPath)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        cell!.tintColor = UIColor.redColor()
        cell!.textLabel?.text = self.items[indexPath.row]
        cell!.detailTextLabel?.text = self.itemDesc[indexPath.row]
        cell!.imageView?.image = self.imageList[indexPath.row] //UIImage(named:"Icon-72")
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell!.selectionStyle = UITableViewCellSelectionStyle.Default
        cell!.detailTextLabel?.textColor = UIColor.redColor()
        return cell!
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }*/


}

