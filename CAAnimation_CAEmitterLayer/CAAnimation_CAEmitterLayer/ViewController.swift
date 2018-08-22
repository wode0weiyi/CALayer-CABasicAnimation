//
//  ViewController.swift
//  CAAnimation_CAEmitterLayer
//
//  Created by 胡志辉 on 2018/8/22.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var leftHeartButton: UIButton!
    
    @IBOutlet weak var centerHeartButton: UIButton!
    
    @IBOutlet weak var rightHeartButton: UIButton!
    
    
    //下雨的layer
    private var rainEmitterLayer:CAEmitterLayer!
    //左边❤️layer
    private var leftHeartLayer:CAEmitterLayer!
    //中间❤️layer
    private var centerHeartLayer:CAEmitterLayer!
    //右边❤️layer
    private var rightHeartLayer:CAEmitterLayer!
    //gravity❤️layer
    private var leftGravityLayer:CAEmitterLayer!
    private var rightGravityLayer:CAEmitterLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpRainEmitterLayer()
        self.setUpLeftHeartEmitterLayer()
        self.setUpCenterHeartLayer()
        self.setUpRightHeartLayer()
        
        
        /*LeftGravityLayer  rightGravityLayer*/
        leftGravityLayer = CAEmitterLayer()
        rightGravityLayer = CAEmitterLayer()
        self.setUpGratilyEmitterLayer(layer: leftGravityLayer, point: CGPoint(x: 0, y: view.bounds.height), angle: -CGFloat.pi/4, angleRange: CGFloat.pi/4)
        self.setUpGratilyEmitterLayer(layer: rightGravityLayer, point: CGPoint(x: view.bounds.width, y: view.bounds.height), angle: CGFloat.pi/4 * 5, angleRange: CGFloat.pi/4)
    }

    
    @IBAction func rainButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        //设置动画
        let rainAnimation = CABasicAnimation(keyPath: "birthRate")
        rainAnimation.duration = 3.0
        if rainEmitterLayer.birthRate == 0 {
            rainAnimation.fromValue = 0
            rainAnimation.toValue = 1
            rainEmitterLayer.birthRate = 1
        }else{
            rainAnimation.fromValue = 1
            rainAnimation.toValue = 0
            rainEmitterLayer.birthRate = 0
        }
        rainEmitterLayer.add(rainAnimation, forKey: "birthRate")
        DispatchQueue.main.asyncAfter(deadline: .now() + rainAnimation.duration) {
            [weak self] in
            /*
             guard语句和if语句有点类似，都是根据其关键字之后的表达式的布尔值决定下一步执行什么。但与if语句不同的是，guard语句只会有一个代码块，不像if语句可以if else多个代码块。
             
             那么guard语句的作用到底是什么呢？顾名思义，就是守护。guard语句判断其后的表达式布尔值为false时，才会执行之后代码块里的代码，如果为true，则跳过整个guard语句
             */
            guard self != nil else{return}
            sender.isUserInteractionEnabled = true
        }
        
    }
    

    @IBAction func leftHeartButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        //设置时间参数
        leftHeartLayer.beginTime = CACurrentMediaTime() - 1
        leftHeartLayer.birthRate = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            guard let strongSelf = self else{return}
            strongSelf.leftHeartLayer.birthRate = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            guard self != nil else {return}
            sender.isUserInteractionEnabled = true
        }
        
    }
    

    @IBAction func centerHeartButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        //设置时间参数
        centerHeartLayer.beginTime = CACurrentMediaTime()//在0.2秒后设置birthrate=0,这个0.2秒的时间内，cell只生成一部分，并没有2000个全部完成。
        centerHeartLayer.birthRate = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {[weak self] in
            guard let strongSelf = self else {return}
           strongSelf.centerHeartLayer.birthRate = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            guard self != nil else {return}
            sender.isUserInteractionEnabled = true
        }
    }
    
    
    @IBAction func rightHeartButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        //设置时间参数
        rightHeartLayer.beginTime = CACurrentMediaTime()
        /*所有的cells是在一定时间里面生成的，并不是同一时刻生成的，所以如果设置的延迟时间过少的话，cells有可能没有或者只有一两个，这里要注意*/
        rightHeartLayer.birthRate = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            guard let strongSelf = self else {return}
            strongSelf.rightHeartLayer.birthRate = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {[weak self] in
            guard self != nil else {return}
            sender.isUserInteractionEnabled = true
        }
    }
    
    
    @IBAction func gravityButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        leftGravityLayer.beginTime = CACurrentMediaTime()
        rightGravityLayer.beginTime = CACurrentMediaTime()
        leftGravityLayer.birthRate = 1
        rightGravityLayer.birthRate = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {[weak self] in
            guard let strongSelf = self else {return}
            strongSelf.leftGravityLayer.birthRate = 0
            strongSelf.rightGravityLayer.birthRate = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
            guard self != nil else {return}
            sender.isUserInteractionEnabled = true
        }
    }
    
    
}


//MARK: - setUp
extension ViewController{
    /**
     * 心形雨
     */
    private func setUpRainEmitterLayer(){
        rainEmitterLayer = CAEmitterLayer()
        //渲染模式
        rainEmitterLayer.renderMode = kCAEmitterLayerOldestFirst;
        //发射模式，为线性边缘
        rainEmitterLayer.emitterMode = kCAEmitterLayerOutline;
        //发射源的形状，线性的(就是一条线上都可以发射粒子)
        rainEmitterLayer.emitterShape = kCAEmitterLayerLine;
        //设置发射源的位置
        rainEmitterLayer.emitterPosition = CGPoint(x: view.bounds.midX, y: 0)
        //设置发射源的范围
        rainEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        //设置动画默认停止
        rainEmitterLayer.birthRate = 0
        
        //初始化CAEmitterCell
        let cell = CAEmitterCell()
        //设置cell的内容
        cell.contents = #imageLiteral(resourceName: "Heart_red").cgImage
        //设置scale的系数
        cell.scale = 0.1
        //设置周期时间（每个粒子在屏幕中持续的时间）
        cell.lifetime = 5
        //设置粒子数
        cell.birthRate = 1000
        //设置粒子加速度
        cell.velocity = 500
        //设置发射方向(x-y屏面)
        cell.emissionLongitude = CGFloat.pi
        //设置粒子cell
        rainEmitterLayer.emitterCells = [cell]
        
        self.view.layer.addSublayer(rainEmitterLayer)
    
    }
    
    /**
     * 直线上升心
     */
    private func setUpLeftHeartEmitterLayer(){
        //设置leftHeartLayer
        leftHeartLayer = CAEmitterLayer()
        //设置发射源的形状(default value，emit orientation is right)
        leftHeartLayer.emitterShape = kCAEmitterLayerPoint;
        //设置发射粒子的模式(default value)
        leftHeartLayer.emitterMode = kCAEmitterLayerVolume;
        //设置渲染模式
        leftHeartLayer.renderMode = kCAEmitterLayerOldestFirst
        //设置发射源的位置
        leftHeartLayer.emitterPosition = leftHeartButton.center
        //设置birthRate
        leftHeartLayer.birthRate = 0
        
        //设置CAEmitterCell
        let cell = CAEmitterCell()
        //设置cell的contents
        cell.contents = #imageLiteral(resourceName: "Heart_red").cgImage
        //设置周期时间
        cell.lifetime = 3.0
        //设置粒子数
        cell.birthRate = 1
        //设置粒子加速度
        cell.velocity = 50
        //设置粒子的透明度变化值
        cell.alphaSpeed = -1
        //设置粒子scale系数
        cell.scale = 0.5
        //设置发射角度
        cell.emissionLongitude = -CGFloat.pi/2
        
        leftHeartLayer.emitterCells = [cell]
        self.view.layer.addSublayer(leftHeartLayer)
        
    }
    
    /**
     * 粒子放射效果
     */
    private func setUpCenterHeartLayer(){
        //设置centerHeartLayer
        centerHeartLayer = CAEmitterLayer()
        //设置发射源粒的形状
        centerHeartLayer.emitterShape = kCAEmitterLayerCircle
        //设置发射粒子的模式
        centerHeartLayer.emitterMode = kCAEmitterLayerOutline
        //设置渲染效果
        centerHeartLayer.renderMode = kCAEmitterLayerOldestFirst
        //设置发射源的位置
        centerHeartLayer.emitterPosition = centerHeartButton.center
        //设置发射源的大小
        centerHeartLayer.emitterSize = centerHeartButton.bounds.size
        centerHeartLayer.birthRate = 0
        
        //设置CAEmitterCell
        let cell = CAEmitterCell()
        //设置cell的内容
        cell.contents = #imageLiteral(resourceName: "Heart_red").cgImage
        //设置周期时间
        cell.lifetime = 1
        //设置scale大小
        cell.scale = 0.05
        //设置粒子数
        cell.birthRate = 2000
        //设置scale的speed
        cell.scaleSpeed = -0.02
        //设置alpha的speed
        cell.alphaSpeed = -1
        //设置粒子的速度
        cell.velocity = 30
        
        centerHeartLayer.emitterCells = [cell]
        self.view.layer.addSublayer(centerHeartLayer)
        
    }
    
    /**
     * 曲线上升心形动画效果
     */
    private func setUpRightHeartLayer(){
        //设置rightHeartLayer
        rightHeartLayer = CAEmitterLayer()
        //设置发射源的形状
        rightHeartLayer.emitterMode = kCAEmitterLayerPoint
        //设置发射源的发射模式
//        rightHeartLayer.emitterShape = kCAEmitterLayerVolume
        //设置渲染模式
        rightHeartLayer.renderMode = kCAEmitterLayerOldestFirst
        //设置发射源的位置
        rightHeartLayer.emitterPosition = rightHeartButton.center
        //设置birthRate
        rightHeartLayer.birthRate = 0
        
        //初始化CAEmitterLayer
        let cell = CAEmitterCell()
        //设置cell的contents
        cell.contents = #imageLiteral(resourceName: "Heart_red").cgImage
        //设置粒子数
        cell.birthRate = 5
        //设置周期时间
        cell.lifetime = 1
        //设置cell的scale系数
        cell.scale = 0.5
        //设置scale的speed系数
//        cell.scaleSpeed = -0.1
        //设置alpha的speed系数
        cell.alphaSpeed = -1
        //设置粒子速度
        cell.velocity = 50
        //设置粒子发射角度
        cell.emissionLongitude = -CGFloat.pi/2
        cell.emissionRange = CGFloat.pi/4
        
        rightHeartLayer.emitterCells = [cell]
        self.view.layer.addSublayer(rightHeartLayer)
    }
    
    private func setUpGratilyEmitterLayer(layer:CAEmitterLayer!,point:CGPoint!,angle:CGFloat!,angleRange:CGFloat!){
        //设置发射源的形状
        layer.emitterMode = kCAEmitterLayerPoint
        //设置发射源的发射模式
        layer.emitterMode = kCAEmitterLayerVolume
        //设置渲染模式
        layer.renderMode = kCAEmitterLayerOldestFirst
        //设置发射源的位置
        layer.emitterPosition = point
        //设置birthRate
        layer.birthRate = 0
        
        //初始化红❤️EmitterCell
        let redCell = CAEmitterCell()
        //设置cell的contents
        redCell.contents = #imageLiteral(resourceName: "Heart_red").cgImage
        //设置cell的scale
        redCell.scale = 0.5
        //设置alpha
        redCell.alphaSpeed = -0.1
        //设置周期时间
        redCell.lifetime = 20
        //设置粒子速度
        redCell.velocity = 100
        //设置粒子个数
        redCell.birthRate = 10
        //设置Y轴方向的分支速度
        redCell.yAcceleration = 20
        //设置发射角度
        redCell.emissionLongitude = angle
        //设置发射角度的浮动值(这个浮动值是基于emissionLongitude的角度位置的，比如emissionLongitude是CGFloat.pi/4,emissionRange为CGFloat.pi/4，则发射点发射角度浮动范围就在CGFloat.pi/4-CGFloat.pi/8到 CGFloat.pi/4 + CGFloat.pi/8)
        redCell.emissionRange = angleRange
        //粒子自旋角度
        redCell.spin = 0
        //粒子自旋角度浮动值
        redCell.spinRange = CGFloat.pi * 2
        
        //初始化蓝❤️EmitterCell
        let blueCell = CAEmitterCell()
        //设置cell的contents
        blueCell.contents = #imageLiteral(resourceName: "Heart_blue").cgImage
        //设置scale
        blueCell.scale = 0.5
        //设置周期时间
        blueCell.lifetime = 20
        //设置粒子数
        blueCell.birthRate = 5
        //设置粒子速度
        blueCell.velocity = 130
        //设置alpha
        blueCell.alphaSpeed = -0.1
        //设置Y轴的分支速度
        blueCell.yAcceleration = 20
        //设置发射角度
        blueCell.emissionLongitude = angle
        //设置发射角度浮动值
        blueCell.emissionRange = angleRange
        //设置自旋角度
        blueCell.spin = 0
        //设置自旋角度浮动值
        blueCell.spinRange = CGFloat.pi * 2
        
        layer.emitterCells = [redCell,blueCell]
        
        view.layer.addSublayer(layer)
    }
    
}



