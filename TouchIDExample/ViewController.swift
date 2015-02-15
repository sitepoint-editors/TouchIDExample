//
//  ViewController.swift
//  TouchIDExample
//
//  Created by Jordan Morgan on 2/13/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController
{
    @IBOutlet weak var lblAuthResult: UILabel!

    //MARK: VC Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: Touch ID Logic
    @IBAction func beginTouchIDAuthCheck()
    {
        let authContext:LAContext = LAContext()
        var error:NSError?
        
        //Is Touch ID hardware available & configured?
        if(authContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&error))
        {
            //Perform Touch ID auth
            authContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Testing Touch ID", reply: {(wasSuccessful:Bool, error:NSError?) in
                
                if(wasSuccessful)
                {
                    //User authenticated
                    self.writeOutAuthResult(error)
                }
                else
                {
                    //There are a few reasons why it can fail, we'll write them out to the user in the label
                    self.writeOutAuthResult(error)
                }
                
            })
            
        }
        else
        {
            //Missing the hardware or Touch ID isn't configured
            self.writeOutAuthResult(error)
        }
    }
    
    
    //MARK: Update results
    func writeOutAuthResult(authError:NSError?)
    {
        dispatch_async(dispatch_get_main_queue(), {() in
            if let possibleError = authError
            {
                self.lblAuthResult.textColor = UIColor.redColor()
                self.lblAuthResult.text = possibleError.localizedDescription
            }
            else
            {
                self.lblAuthResult.textColor = UIColor.greenColor()
                self.lblAuthResult.text = "Authentication successful."
            }
        })
        
    }

}

