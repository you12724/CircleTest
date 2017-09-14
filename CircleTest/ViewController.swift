//
//  ViewController.swift
//  CircleTest
//
//  Created by 堀　洋輔 on 2017/09/13.
//  Copyright © 2017年 yosuke_hori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        targetView.layer.cornerRadius = 120.0
        drawCircle(targetView: targetView)
        drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 0.0, toValue: 1.0, duration: 10.0, count: 1, flag: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var targetView: UIView!
    // CAShapeLayerインスタンスを生成
    var circle: CAShapeLayer = CAShapeLayer()
    // ※前提条件としてtargetViewが正方形であること
    func drawCircle(targetView: UIView) {
        
        // ゲージ幅
        let lineWidth: CGFloat = 20
        
        // 描画領域のwidth
        let viewScale: CGFloat = targetView.bounds.size.width
        
        // 円のサイズ
        let radius: CGFloat = viewScale - lineWidth
        
        // 円の描画path設定
        
        circle.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: radius, height: radius), cornerRadius: radius / 2).cgPath
        
        // 円のポジション設定
        circle.position = CGPoint(x: lineWidth / 2, y: lineWidth / 2)
        
        // 塗りの色を設定
        circle.fillColor = UIColor.clear.cgColor
        
        // 線の色を設定
        circle.strokeColor = UIColor.white.cgColor
        
        // 線の幅を設定
        circle.lineWidth = lineWidth
        
        // 該当のUIViewのlayerにsublayerとしてCALayerを追加
        targetView.layer.addSublayer(circle)
        
        // duration0.0のアニメーションにて初期描画(線が書かれていない状態)にしておく
        drawCircleAnimation(key: "strokeEnd", animeName: "updateGageAnimation", fromValue: 0.0, toValue: 0.0, duration: 0.1, count: 1.0, flag: false)
        
    }

    func drawCircleAnimation(key: String, animeName: String, fromValue: CGFloat, toValue: CGFloat, duration: TimeInterval, count: Float, flag: Bool) {
        
        // アニメーションkeyを設定
        let drawAnimation = CABasicAnimation(keyPath: key)
        
        // アニメーション間隔の指定
        drawAnimation.duration = duration  // "animate over 10 seconds or so.."
        
        // 繰り返し回数の指定
        drawAnimation.repeatCount = count  // Animate only once..
        
        // 起点と目標点の変化比率を設定 (0.0 〜 1.0)
        drawAnimation.fromValue = fromValue
        drawAnimation.toValue = toValue
        
        // イージングを決定
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // アニメ完了時の描画を保持
        drawAnimation.isRemovedOnCompletion = false
        drawAnimation.fillMode = kCAFillModeForwards
        
        // 逆再生の指定
        drawAnimation.autoreverses = flag
        
        // Add the animation to the circle
        circle.add(drawAnimation, forKey: animeName)
    }

}

