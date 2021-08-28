

//
//  Reviews_ViewController.swift
//  FGB
//
//  Created by iOS-Appentus on 07/03/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Reviews_ViewController: UIViewController {

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btn_back(_ sender:Any) {
        dismiss(animated: true, completion: nil)
    }


}





extension Reviews_ViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_Rating = tableView.dequeueReusableCell(withIdentifier: "cell_Rating", for:indexPath) as! Reviews_TableViewCell
        
        return cell_Rating
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}



