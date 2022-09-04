//
//  EditController.swift
//  nyamu
//
//  Created by 亀井翔太 on 2022/09/05.
//

import UIKit
protocol editDelegate{
    func viewDidLoad()
}
class EditController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var subview2: UIView!
    
    @IBOutlet weak var memoentry: UITextView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var titleentry: UITextField!
    var editdelegate: editDelegate?
    var sliceindex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        let default_data:Array<[String:Any]> = [["value": Float(100 as! Int),"label":"悩み事なし","explanation":"悩み事を追加しましょう"]]
        let e_data = UserDefaults.standard.object(forKey: "data") ?? default_data
        let e = e_data as! Array<[String:Any]>
        self.titleentry.text = e[sliceindex]["label"] as! String
        self.slider.value = e[sliceindex]["value"] as! Float
        self.memoentry.text = e[sliceindex]["explanation"] as! String
        // Do any additional setup after loading the view.
    }
    @objc func tapped(_ sender: UITapGestureRecognizer){
        editdelegate?.viewDidLoad()
        dismiss(animated: true, completion: nil)
        }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
        {
            if (touch.view!.isDescendant(of: subview2)) {
                return false
            }
            return true
            
        }

    @IBAction func enter(_ sender: Any) {
        let nayami = titleentry.text!
        let memo = memoentry.text!
        let levels = slider.value
        var comp: Array<Any> = []
        if (nayami != ""){
            let default_data:Array<[String:Any]> = [["value": 100,"label":"悩み事なし","explanation":"悩み事を追加しましょう"]]
            let e_data = UserDefaults.standard.object(forKey: "data") ?? default_data
            let e = e_data as! Array<[String:Any]>
            for (j, i) in e.enumerated(){
                if sliceindex != j{
                        comp.append(i)
                }
                else{
                    comp.append(["value":Int(levels), "label": nayami, "explanation": memo])
                }
                }
            
            UserDefaults.standard.set(comp, forKey: "data")
            editdelegate?.viewDidLoad()
            dismiss(animated: true, completion: nil)
            
        }
        print(comp)
    }
    
    @IBAction func del(_ sender: Any) {
        var comp: Array<Any> = []
        let default_data:Array<[String:Any]> = [["value": 100,"label":"悩み事なし","explanation":"悩み事を追加しましょう"]]
        let e_data = UserDefaults.standard.object(forKey: "data") ?? default_data
        let e = e_data as! Array<[String:Any]>
        for (j, i) in e.enumerated(){
            if sliceindex != j{
                comp.append(i)
            }
            }
        if comp.isEmpty{
            UserDefaults.standard.removeObject(forKey: "data")
        
        }
        else{
            UserDefaults.standard.set(comp, forKey: "data")
        }
        editdelegate?.viewDidLoad()
        dismiss(animated: true, completion: nil)
    }
}
