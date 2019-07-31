//
//  Created by Zeeshan Ahmed.
//  Copyright © 2018 Zeeshan Ahmed. All rights reserved.
//

import UIKit

class cls_ViewController_G: UIViewController {
    
    
    @IBOutlet weak var lbl_Menu_User_ID_Email: UILabel!
    
    var str_User_ID_Navigated = ""
    var hosting_server = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_Menu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"cls_ViewController_M") as! cls_ViewController_Menu;
        
        viewController.hosting_server = self.hosting_server

        self.present(viewController, animated: true)
    }
    
    @IBAction func btn_Genes_CodeNonCoded(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"cls_ViewController_G") as! cls_ViewController_G;
        viewController.str_User_ID_Navigated=lbl_Menu_User_ID_Email.text!
        viewController.hosting_server = self.hosting_server

        self.present(viewController, animated: true)
    }
    
}
