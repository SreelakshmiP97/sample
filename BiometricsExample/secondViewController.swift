//
//  secondViewController.swift
//  BiometricsExample
//
//  Created by Deepak on 09/12/21.
//

import UIKit
import Charts

class secondViewController: UIViewController, ChartViewDelegate {
    
    var LineChart = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()

        LineChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        LineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        LineChart.center = view.center
        view.addSubview(LineChart)
        var entries1 = [ChartDataEntry(x: 0.0, y: 1.0),
                        ChartDataEntry(x: 2.0, y: 5.0),ChartDataEntry(x: 3.0, y: 8.0),ChartDataEntry(x: 4.0, y: 4.0),ChartDataEntry(x: 1.0, y: 6.0),ChartDataEntry(x: 2.0, y: 2.0),ChartDataEntry(x: 3.0, y: 6.0),ChartDataEntry(x: 5.0, y: 5.0),ChartDataEntry(x: 6.0, y: 8.0),ChartDataEntry(x: 8.0, y: 10.0)
        ]
        var entries = [ChartDataEntry]()
        for x in 0..<10 {
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: entries1)
        set.colors = ChartColorTemplates.colorful()
        let data = LineChartData(dataSet: set)
        LineChart.data = data
    }
   

}
