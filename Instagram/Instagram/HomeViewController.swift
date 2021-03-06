//
//  HomeViewController.swift
//  Instagram
//
//  Created by Swapnil Tamrakar on 3/15/17.
//  Copyright © 2017 Swapnil Tamrakar. All rights reserved.
//

import UIKit
import Parse


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var posts = [PFObject]()

    @IBOutlet weak var tablView: UITableView!
    
    func getData(){
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
                print("Post is : ", posts)
                // do something with the data fetched
            } else {
                print("Error! : ", error?.localizedDescription)
                // handle error
            }
            self.tablView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablView.delegate = self
        tablView.dataSource = self
        tablView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.posts.count)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! HomeTableViewCell
        let post = posts[indexPath.row]
        let caption = post["caption"] as? String
        let photoPFFile = post["media"] as? PFFile
        let created = post["creationTime"] as? Date
        print("PhotoPFFFile is : ", photoPFFile)
        print("Check")
        cell.workingImageView.file = photoPFFile
        print("error")
        cell.workingImageView.loadInBackground()
        
        cell.captionLabel.text = caption
        cell.usernameLabel.text = PFUser.current()?.username
        return cell

        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
