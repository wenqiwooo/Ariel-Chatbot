//
//  ViewController.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // var nMain: NeuralNetwork
    var fl: FileLoader
    var dp: DataProcessor
    var rp: RequestProcessor


//    @IBOutlet weak var userInput: UITextField!
//    @IBOutlet weak var replyLabel: UILabel!
//    
//    @IBAction func userSubmit(sender: AnyObject) {
//        var input = userInput.text!
//        var reply = rp.sendForMain(rp.processForMain(dp.processStringForMain(input)), s: input)
//        replyLabel.text = reply
//    }
//    
    required init(coder aDecoder: NSCoder) {
        // self.nMain = NeuralNetwork(nInput: N_INPUT_MAIN, nHidden: 9, nOutput: N_OUTPUT_MAIN)
        self.fl = FileLoader(path: "main_dataset", ext: "", nOutput: N_OUTPUT_MAIN, type: 0)
        // self.nMain.trainNetwork(fl.mainDataSet, generalizationSet: fl.mainDataSet, validationSet: fl.mainDataSet)
        self.dp = DataProcessor()
        self.rp = RequestProcessor()
        
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // replyLabel.numberOfLines = 0
        // replyLabel.text = String(nMain.trainingSetAccuracy)
        print("THIS IS VIEW CONTROLLER")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

