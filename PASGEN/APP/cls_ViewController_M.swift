//
//  cls_ViewController_Main.swift
//  PROMIS-APP
//
//  Created by Zeeshan Ahmed on 11/17/18.
//  Copyright © 2018 Zeeshan Ahmed. All rights reserved.
//

import UIKit

class cls_ViewController_Main: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txt_User_Email: UITextField!
    @IBOutlet weak var txt_User_Password: UITextField!
    
    let ACCEPTABLE_CHARACTERS = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txt_User_Email.delegate = self
        self.txt_User_Password.delegate = self

        // Do any additional setup after loading the view.
        recordDevice();
        check_current_version();


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Invoke touch screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Invoke Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txt_User_Password.resignFirstResponder()
        return (true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
        return (string == filtered)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Code to run any event at execution.
    }

    //Login
    @IBAction func btn_User_Login(_ sender: Any) {
        userID = txt_User_Email.text!
        userPassword = txt_User_Password.text!
        
        if userID != "" && userPassword != ""
        {
            userLogin()
        }
        else
        {
            self.Alert(Message: "Please enter correct Email ID and Password")
        }
    }
    
    
    //Alert
    func Alert (Message: String){
        
        let alertController = UIAlertController(title: "PROMIS-APP-SUITE", message:
            Message,  preferredStyle: UIAlertController.Style.alert);
        alertController.addAction(UIAlertAction(title: "Alert", style: UIAlertAction.Style.default,handler: nil));
        self.present(alertController, animated: true, completion: nil);
    }
    
    //Device
    func recordDevice()
    {
        let user_reg_device_id = UIDevice.current.identifierForVendor!.uuidString
        print(user_reg_device_id);
        
        var phpfilename = ""

        //let myURL = NSURL(string: "" + phpfilename);
        //let myURL = NSURL(string: "" + phpfilename);
        
        let myURL = NSURL(string: hosting_server + phpfilename);
        print(myURL)

        let request = NSMutableURLRequest(url:myURL! as URL);
        request.httpMethod = "POST";
        
        //let postString = "device=\(user_reg_device_id)";
        let postString = "device=\(user_reg_device_id)";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("Session Error \(error)")
                return;
            }
            else{
                print("No Session Error")
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                //print(myJSON)
                
                //parsing the json
                if let parseJSON = myJSON {
                    var resultValue_msg:String = (parseJSON["message"] as! String?)!;
                    print("message: \(resultValue_msg)")
                    
                    var resultValue_stattus:String = (parseJSON["status"] as! String?)!;
                    print("status: \(resultValue_stattus)")
                    
                    if(resultValue_stattus=="Sucess")
                    {
                        print("Sucess")
                    }
                }
            } catch {
                print(error)
            }
        }
        //executing the task
        task.resume();
    }
    
   
    //Login
    func userLogin()
    {
        let str_User_Email = txt_User_Email.text;
        let str_User_Password = txt_User_Password.text;
        var str_Login_Success_Failed = "Failed";
        
        var phpfilename = ""
        let myURL = NSURL(string: hosting_server + phpfilename);
        
        let request = NSMutableURLRequest(url:myURL! as URL);
        request.httpMethod = "POST";
        
        let postString = "email=\(str_User_Email!)&password=\(str_User_Password!)";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("Session Error \(error)")
                return;
            }
            else{
                print("No Session Error")
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                //print(myJSON)
                
                //parsing the json
                if let parseJSON = myJSON {
                    var resultValue_msg:String = (parseJSON["message"] as! String?)!;
                    print("message: \(resultValue_msg)")
                    
                    var resultValue_stattus:String = (parseJSON["status"] as! String?)!;
                    print("status: \(resultValue_stattus)");
                    
                    if(resultValue_stattus=="Success")
                    {
                        str_Login_Success_Failed = "Sucessfully Login";
                        print(str_Login_Success_Failed);
                        
                        self.Navigate_to_Menue(Message: str_Login_Success_Failed);
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            self.Alert(Message: "Please enter correct Email ID and Password")
                        }
                    }
                    
                }
            } catch {
                print(error)
            }
        }
        task.resume();
    }

    
    @IBAction func btn_Register(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"cls_ViewController_Register") as! cls_ViewController_Register;
        viewController.hosting_server = self.hosting_server
        self.present(viewController, animated: true)
    }
    
    @IBAction func btn_ResetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"cls_ViewController_ResetPassword") as! cls_ViewController_ResetPassword;
        viewController.hosting_server = self.hosting_server
        self.present(viewController, animated: true)
    }
    
    //Search
    func check_current_version()
    {
        let str_Keyword = self.current_Version;
        
        if str_Keyword != ""
        {
            var phpfilename = ""
            
            let myURL = NSURL(string: hosting_server + phpfilename);
            
            let request = NSMutableURLRequest(url:myURL! as URL);
            request.httpMethod = "POST";
            
            let postString = "keyword=\(str_Keyword)";
            
            request.httpBody = postString.data(using: String.Encoding.utf8);
            
            //creating a task to send the post request
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if error != nil{
                    print("Session Error \(error)")
                    return;
                }
                else{
                    print("No Session Error")
                }
                
                //parsing the response
                do {
                    //converting resonse to NSDictionary
                    let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    let let_results: NSArray = myJSON!["results"] as! NSArray
                    self.Arr_Search_Results(arr_results: let_results)
                    
                } catch {
                    print(error)
                }
            }
            task.resume();
        }
        else
        {
            self.Alert(Message: "Please enter value to search")
            
        }
    }
    
    //Search results
    func Arr_Search_Results (arr_results: NSArray){
        print ("Total: " + String(arr_results.count))
        
        DispatchQueue.main.async {
            
            //looping through all the json objects in the array teams
            for i in 0 ..< arr_results.count{
                //print(teams[i] as! NSDictionary)
                
                let let_mvc_Current_Version:String = (arr_results[i] as! NSDictionary)["mvc_Current_Version"] as! String!
                let let_mvc_Sytem_Msg:String = (arr_results[i] as! NSDictionary)["mvc_Sytem_Msg"] as! String!
                
                print("version" + let_mvc_Current_Version)
                
                if let_mvc_Current_Version == self.current_Version
                {
                    print("Welcome")
                }
                else
                {
                    self.new_version = let_mvc_Current_Version
                    self.system_msg = let_mvc_Sytem_Msg
                    self.Navigate_to_Obsolete();

                }
                
            }
            
            //print(arr_results);
        }
    }
    
    //Navigate to main menu
    func Navigate_to_Obsolete (){
        
            DispatchQueue.main.async {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier :"cls_ViewController_Obsolete") as! cls_ViewController_Obsolete;
                viewController.New_Version = self.new_version
                viewController.System_Msg = self.system_msg

                self.present(viewController, animated: true)
                print("obsolete")

            }
    }
    
}
