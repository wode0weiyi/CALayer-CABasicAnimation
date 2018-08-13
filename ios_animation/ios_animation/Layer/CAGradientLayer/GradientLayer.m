//
//  GradientLayer.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "GradientLayer.h"

@implementation GradientLayer


/*懒加载*/
- (CAGradientLayer *)gradientLayer
{
    if(!_gradientLayer){
//        初始化一个CAGradientLayer对象
        _gradientLayer = [CAGradientLayer layer];
//        设置位置
        _gradientLayer.frame = CGRectMake(100, 100, 200, 30);
//        设置颜色渐变数组
        /*
         *   (__bridge <#type#>)<#expression#>) 仅仅将值的地址进行转换，并没有转移对象的所有权，如果被桥接的对象释放，则桥接后的值也无法使用。在ARC下使用__bridge，因为所有权仍然属于OC，因此归ARC管制，不必手动释放。
         */
        _gradientLayer.colors = @[CGColorToNSObject([UIColor clearColor]),CGColorToNSObject([UIColor redColor])];
//         设置渐变颜色分割点
//        _gradientLayer.locations = @[@(0),@(0.5),@(0.9)];
//        使得颜色像素均匀变化（仅有一个选择）
        _gradientLayer.type = kCAGradientLayerAxial;
//        从左上角到右上角
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 0);
        
    }
    return _gradientLayer;
}

/*定义一个底层的CAGradientLayer*/
- (CAGradientLayer *)circleGradientLayer
{
    if(!_circleGradientLayer){
        //初始化一个变量
        _circleGradientLayer = [CAGradientLayer layer];
        //设置大小
        _circleGradientLayer.frame = CGRectMake(100, 320, 100, 100);
        //设置渐变颜色数组
        _circleGradientLayer.colors = @[CGColorToNSObject([UIColor redColor]),CGColorToNSObject([UIColor yellowColor]),CGColorToNSObject([UIColor greenColor])];
        //设置开始的point（开始的point取值范围为(0,0)->(1,1)）
        _circleGradientLayer.startPoint = CGPointMake(0, 0);
        //设置结束的point（结束的point的取值范围为(0,0)->(1,1)）
        _circleGradientLayer.endPoint = CGPointMake(0, 1);
    }
    return _circleGradientLayer;
}

/*定义一个CAGradientLayer的mask蒙版*/
- (CAShapeLayer *)circleShaperLayer
{
    if(!_circleShaperLayer){
        //初始化一个CAShapeLayer的变量
        _circleShaperLayer = [CAShapeLayer layer];
        //设置线宽
        _circleShaperLayer.lineWidth = 5;
        //设置填充色，默认为黑色，如果不想要填充色，就设置为clearColor
        _circleShaperLayer.fillColor = [UIColor clearColor].CGColor;
        //设置线条颜色
        _circleShaperLayer.strokeColor = [UIColor redColor].CGColor;
        /*
         * 设置圆环的路劲
         * ArcCenter 圆心坐标，坐标系是_circleGradientLayer
         * radius 半径
         * startAngle 起始点
         * endAngle 结束点
         * clockwise 绘画的方向，0为逆时针，1为顺时针
         */
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:45 startAngle:0 endAngle:2*M_PI clockwise:0];
        _circleShaperLayer.path = path.CGPath;
        //创建一个CABasicAnimation动画，keyPath的值为strokeEnd
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        //动画时长
        animation.duration = 3.0;
        //动画开始的值
        animation.fromValue = @(0);
        //动画结束的值
        animation.toValue = @(1);
        //动画的执行刺手
        animation.repeatCount = 100;
        //添加动画
        [_circleShaperLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    return _circleShaperLayer;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.gradientLayer];
        [self.layer addSublayer:self.circleGradientLayer];
        //设置mask
       _circleGradientLayer.mask = self.circleShaperLayer;
    }
    return self;
}

@end
