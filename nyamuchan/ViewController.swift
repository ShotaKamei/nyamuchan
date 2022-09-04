
import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate, modalDelegate, editDelegate{

    

    @IBOutlet weak var pieChartsView: PieChartView!
    @IBOutlet weak var naya: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.removeObject(forKey: "data")
        print("Hello")
        let sampleImage = UIImage(named: "Vectornaya.png")
        naya.image = sampleImage
        naya.isUserInteractionEnabled = true
        naya.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:))))

        pieChartsView.delegate = self
        let default_data:Array<[String:Any]> = [["value": 100,"label":"悩み事なし","explanation":"悩み事を追加しましょう"]]
        let e_data = UserDefaults.standard.object(forKey: "data") ?? default_data
        let e = e_data as! Array<[String:Any]>
        var dataEntries: [PieChartDataEntry] = []
        for i in e{
 
            dataEntries.append(PieChartDataEntry(value: Double(i["value"] as! Int), label: (i["label"] as! String)))
        }
        
        

        // グラフに表示するデータのタイトルと値
        
        let dataSet = PieChartDataSet(entries: dataEntries, label: "テストデータ")

        // グラフの色
        dataSet.colors = ChartColorTemplates.vordiplom()
        // グラフのデータの値の色
        dataSet.valueTextColor = UIColor.black
        // グラフのデータのタイトルの色
        dataSet.entryLabelColor = UIColor.black

        self.pieChartsView.data = PieChartData(dataSet: dataSet)
        self.pieChartsView.highlightValue(nil, callDelegate: false)
        // データを％表示にする
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1.0
        self.pieChartsView.data?.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        self.pieChartsView.usePercentValuesEnabled = true
        self.pieChartsView.drawHoleEnabled = false
        self.pieChartsView.rotationEnabled = false
        self.pieChartsView.legend.enabled = false
        
        
        view.addSubview(self.pieChartsView)
    }
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ModalSegue", sender: nil)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            
                if let dataSet = pieChartsView.data?.dataSets[highlight.dataSetIndex] {
                    let sliceIndex: Int = dataSet.entryIndex(entry: entry)
                    performSegue(withIdentifier: "EditSegue", sender: sliceIndex)
                    print(sliceIndex)
                
            }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ModalSegue"{
                //  遷移先のNextViewControllerクラスを取得
                let nextVC = segue.destination as! ModalController
                //  protocolを紐付ける
                nextVC.modaldelegate = self
            }
            if segue.identifier == "EditSegue"{
                let nextVC = segue.destination as! EditController
                nextVC.sliceindex = sender as! Int
                nextVC.editdelegate = self
        }
        }
}
