import UIKit

class PieGraphView: UIView {

    var _params:[Dictionary<String,Any>]!
    var _end_angle:CGFloat!

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect,params:[Dictionary<String,Any>]) {
        super.init(frame: frame)
        _params = params;
        self.backgroundColor = UIColor.clear;
        _end_angle = -CGFloat(M_PI / 2.0);
    }


    func update(link:AnyObject){
        var angle = CGFloat(M_PI*2.0 / 100.0);
        _end_angle = _end_angle +  angle
        if(_end_angle > CGFloat(M_PI*2)) {
            //終了
            link.invalidate()
        } else {
            self.setNeedsDisplay()
        }

    }

    func startAnimating(){
        print("start")
        let displayLink = CADisplayLink(target: self, selector: Selector(("update:")))
        displayLink.add(to:RunLoop.current, forMode: RunLoop.Mode.common)
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

        let context:CGContext = UIGraphicsGetCurrentContext()!;
        var x:CGFloat = rect.origin.x;
        x += rect.size.width/2;
        var y:CGFloat = rect.origin.y;
        y += rect.size.height/2;
        var max:CGFloat = 0;
        for dic : Dictionary<String,Any> in _params {
            var value = CGFloat(dic["value"] as! Int)
            max += value;
        }


        var start_angle:CGFloat = -CGFloat(M_PI / 2);
        var end_angle:CGFloat    = 0;
        var radius:CGFloat  = x - 10.0;
        for dic : Dictionary<String,Any> in _params {
            let value = CGFloat(dic["value"] as! Int)
            end_angle = start_angle + CGFloat(M_PI*2) * (value/max);
            if(end_angle > _end_angle) {
                end_angle = _end_angle;
            }
            let circle = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: radius, startAngle: start_angle, endAngle: end_angle, clockwise: true)
            // 内側の色
            UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).setFill()
            // 内側を塗りつぶす
            circle.fill()
            // 線の色
            UIColor(red: 0, green: 0, blue: 1, alpha: 1.0).setStroke()
            // 線の太さ
            circle.lineWidth = 2.0
            // 線を塗りつぶす
            circle.stroke()
            start_angle = end_angle;
        }

    }

}

