//
//  ThirdViewController.swift
//  BiometricsExample
//
//  Created by Deepak on 10/12/21.
//

import UIKit
//import SwiftCharts
import SwiftChart


class ThirdViewController: UIViewController, ChartDelegate {
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    

    @IBOutlet weak var Chart: Chart!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let chartConfig = ChartConfigXY(
//            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
//            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
//        )
//        let frame = CGRect(x: 0, y: 70, width: 300, height: 500)
//        let chart = LineChart(frame: frame, chartConfig: chartConfig, xTitle: "X axis", yTitle: "y axis", lines: [
//            (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
//            (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
//        ])
        Chart.delegate = self
        
        let data = [
          (x: 1, y: 0),
          (x: 2, y: 3.1),
          (x: 3, y: 2),
          (x: 4, y: 4.2),
          (x: 5, y: 5),
          (x: 6, y: 9),
          (x: 7, y: 8),
          (x: 8, y: 9),
          (x: 9, y: 10),
          (x: 10, y: 10)
        ]
        let series = ChartSeries(data: data)
        series.area = true
        series.color = .green
        Chart.labelColor = .white
        Chart.add(series)
       
    }
    

   

}
