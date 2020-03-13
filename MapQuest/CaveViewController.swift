//
//  CaveViewController.swift
//  CommuterChronicles
//
//  Created by phrank on 3/13/20.
//  Copyright © 2020 Frank Lenoci. All rights reserved.
//

import UIKit

class CaveViewController: UIViewController {

    @IBOutlet weak var chestClose: UIImageView!
    @IBOutlet weak var chestOpen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chestClose.isHidden = false
        chestOpen.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chetClick(_ sender: UIButton) {
            if (chestClose.isHidden == true)
             {
                chestOpen.isHidden = false
                chestClose.isHidden = true
             }
             else
             {
                chestOpen.isHidden = true
                chestClose.isHidden = false
             }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
