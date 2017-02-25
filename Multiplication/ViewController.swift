//
//  ViewController.swift
//  Multiplication
//
//  Created by Daniel Oraca on 22/02/2017.
//  Copyright © 2017 Daniel Oraca. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    var audioPlayer:AVAudioPlayer!
    var numberOne:Int = 0;
    var numberTwo:Int = 0;
    var sign = "*";
    var win = true;
    var totalGood = 0;
    var totalBad = 0;
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var totalGoodLabel: UILabel!
    @IBOutlet weak var totalBadLabel: UILabel!
    @IBOutlet weak var number_one: UILabel!
    @IBOutlet weak var number_two: UILabel!
    
    @IBOutlet weak var myResponse: UITextField!
    @IBOutlet weak var imageResponse: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myResponse.delegate = self
        
        self.myResponse.returnKeyType = .done
        generateNew()
    }
    
    @IBAction func responseEnd(_ sender: Any) {
        if (myResponse.text != "") {
            checkInput()
        }
        myResponse.becomeFirstResponder()  //if desired
    }
    
    @IBAction func primActTrig(_ sender: Any) {
        Swift.print("aaa")
    }
    
    func generateNew() {
        let A: Int = 1
        let B: Int = 10
        
        numberOne = Int(arc4random_uniform(UInt32(B - A + 1))) + A
        numberTwo = Int(arc4random_uniform(UInt32(B - A + 1))) + A
        sign = " x "
        number_one.text = numberOne.description
        number_two.text = sign + numberTwo.description
        myResponse.text = ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var myResult: UILabel!
    @IBOutlet weak var checkResult: UIButton!

    @IBAction func checkResult(_ sender: Any) {
        if (myResponse.text == "") {
            let alert = UIAlertController(title: "Answer!", message: "You forgot to answer", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            checkInput()
        }
    }
    
    func checkInput()
    {
        var calculateI:Int
            calculateI = numberOne * numberTwo
        
        if (calculateI != Int(myResponse.text!)) {
            win = false
            playSound(sender: checkResult)
            totalBad = totalBad + 1
            totalBadLabel.text = "Total Bad: \(totalBad)"
            let imageName = "sad.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 600, y: 480, width: 120, height: 120)
            view.addSubview(imageView)
            
            
            UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                imageView.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
            })
            
        } else {
            win = true
            playSound(sender: checkResult)
            totalGood = totalGood + 1
            totalGoodLabel.text = "Total Good: \(totalGood)"
            let imageName = "happy.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 600, y: 480, width: 120, height: 120)
            view.addSubview(imageView)
            
            UIView.animate(withDuration: 1.0, delay: 1.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                imageView.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
            })
        }
        
        generateNew()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }

    
    @IBAction func playSound(sender: AnyObject) {
        var my_sound = ""
        if (win) {
            my_sound = "success"
        } else {
            my_sound = "error"
        }
        let audioFilePath = Bundle.main.path(forResource: my_sound, ofType: "mp3")
        
        let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
        
        audioPlayer = try! AVAudioPlayer(contentsOf: audioFileUrl)
        
        audioPlayer.play()
        
    }
    
    
    @IBOutlet weak var butNo: UIButton!
    
    @IBAction func butNo(_ sender: Any) {
        myLabel.text = "LOOOOOOSER!!!!!"
        let audioFilePath = Bundle.main.path(forResource: "error", ofType: "mp3")
        
        let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
        
        audioPlayer = try! AVAudioPlayer(contentsOf: audioFileUrl)
        
        audioPlayer.play()
    }
    @IBOutlet weak var butCheck: UIButton!
    
    @IBOutlet weak var testButton: UIButton!
    @IBAction func testBut(_ sender: Any) {
        myLabel.text = "wow"
        let audioFilePath = Bundle.main.path(forResource: "success", ofType: "mp3")
        
        let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
        
        audioPlayer = try! AVAudioPlayer(contentsOf: audioFileUrl)
        
        audioPlayer.play()
    }
}

