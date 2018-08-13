//
//  GradientLayer.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//


/**
 * 这个layer主要是用来做渐变色处理的，
 *
 ** @property(nullable, copy) NSArray *colors;
    渐变色的数组，就是你需要的渐变色是什么样的，这里就可以设置
 
 ** @prperty(nullable,copy) NSArray<NSNumber *> *locations;
    渐变色颜色改变的位置点，取值范围在0-1之间，比如三个颜色要在0，0.3，0.6处变化，就设置这个属性
 
 ** @property CGPoint startPoint;
    渐变色起始点，取值在(0,0)->(1,1),(0,0)表示左上角的坐标，(1,1)表示右下角的坐标
 
 ** @property CGPoint endPoint;
    渐变色结束点，取值在(0,0)->(1,1)
 */

/**
 * 如果要实现渐变色的圆环，则需要设置CAGradientLayer的蒙版mask为CAShapeLayer
 */


#import <UIKit/UIKit.h>

@interface GradientLayer : UIView
/*定义属性,矩形渐变*/
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
/*圆形渐变*/
@property (nonatomic,strong) CAGradientLayer *circleGradientLayer;
/*圆环*/
@property (nonatomic,strong) CAShapeLayer *circleShaperLayer;
@end
