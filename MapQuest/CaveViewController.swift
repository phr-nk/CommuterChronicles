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
    var i = 0
    var cave : Cave!
    override func viewDidLoad() {
        super.viewDidLoad()
        chestClose.isHidden = false
        chestOpen.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chetClick(_ sender: UIButton) {
            if (chestClose.isHidden == false)
             {
                self.i += 1
                chestOpen.isHidden = false
                chestClose.isHidden = true
                if(self.i == 1)
                {
                    let alert = AABlurAlertController()


                    alert.addAction(action: AABlurAlertAction(title: "Take", style: AABlurActionStyle.default) {  _ in
                         print("got some loot")
                         Game.shared.adventurer?.inventory.append(Item(name:"shield", cost: 20))
                       })

                       alert.blurEffectStyle = .regular

                  let image = UIImage(named: "chestopen")
                       alert.alertImage.image = image
                       alert.alertTitle.text = "CHEST"
                       alert.alertSubtitle.text = "You found a chest!"
                       present(alert, animated: true)
                }
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
