//
//  ModalController.swift
//  nyamu
//
//  Created by 亀井翔太 on 2022/09/05.
//

import UIKit
protocol modalDelegate{
    func viewDidLoad()
}

class ModalController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var titleentry: UITextField!
    @IBOutlet weak var memoentry: UITextView!
    @IBOutlet weak var level: UISlider!
    
    var modaldelegate: modalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    @objc func tapped(_ sender: UITapGestureRecognizer){
        modaldelegate?.viewDidLoad()
        dismiss(animated: true, completion: nil)
        }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
        {
            if (touch.view!.isDescendant(of: subview)) {
                return false
            }
            return true
            
        }

    @IBAction func enter(_ sender: Any) {
        let nayami = titleentry.text!
        let memo = memoentry.text!
        let levels = level.value
        var comp: Array<Any> = []
        if (nayami != ""){
            let default_data:Array<[String:Any]> = [["value": 100,"label":"悩み事なし","explanation":"悩み事を追加しましょう"]]
            let e_data = UserDefaults.standard.object(forKey: "data") ?? default_data
            let e = e_data as! Array<[String:Any]>
            for i in e{
                if i["label"] as! String != "悩み事なし"{
                    comp.append(i)
                }
            }
            comp.append(["value":Int(levels), "label": nayami, "explanation": memo])
            UserDefaults.standard.set(comp, forKey: "data")
            modaldelegate?.viewDidLoad()
            dismiss(animated: true, completion: nil)
            
        }
        print(comp)
        
        
    }
    
    

}

