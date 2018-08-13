//
//  ShaperLayer.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ShaperLayer.h"

@implementation ShaperLayer

/*线性的CAShapeLayer*/
- (CAShapeLayer *)lineLayer
{
    if(!_lineLayer){
        _lineLayer = [[CAShapeLayer alloc] init];
//        设置线条颜色
        _lineLayer.strokeColor = [UIColor redColor].CGColor;
//        设置线条宽度
        _lineLayer.lineWidth = 5;
//        绘制线条路径
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 100)];
        [path addLineToPoint:CGPointMake(200, 100)];
//                连接类型为round，就是拐角处的线条类型
        _lineLayer.lineJoin = kCALineJoinRound;
        //线性模版，这是一个NSNumber的数组，索引从1开始记，奇数位数值表示实线长度，偶数位数值表示空白长度。下面表示的是一个等距等宽的虚线。
        _lineLayer.lineDashPattern = @[@5,@5];
//设置layer的path
        _lineLayer.path = path.CGPath;
    }
    return _lineLayer;
}

/*圆形CAShapeLayer*/
- (CAShapeLayer *)circleLayer
{
    if(!_circleLayer){
        
        _circleLayer = [[CAShapeLayer alloc] init];
        _circleLayer.strokeColor = [UIColor yellowColor].CGColor;
        _circleLayer.lineWidth = 5;
        _circleLayer.position = CGPointMake(70, 150);
        _circleLayer.fillColor = [UIColor redColor].CGColor;
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
        _circleLayer.path = path.CGPath;
    }
    return _circleLayer;
}

/*弧线CAShapeLayer*/
- (CAShapeLayer *)radianLayer
{
    if(!_radianLayer){
        _radianLayer = [[CAShapeLayer alloc] init];
        _radianLayer.strokeColor = [UIColor orangeColor].CGColor;
//        设置fillColor填充色为透明，这样绘制的时候才会以线的形式绘制
        _radianLayer.fillColor = [UIColor clearColor].CGColor;
//        设置layer的路径
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 250)];
//        第一个参数为结束点，第二个参数为控制点
        [path addQuadCurveToPoint:CGPointMake(250, 250) controlPoint:CGPointMake(150, 300)];
        _radianLayer.path = path.CGPath;
        
    }
    return _radianLayer;
}

/*曲线*/
- (CAShapeLayer *)curveLayer
{
    if(!_curveLayer){
        _curveLayer = [[CAShapeLayer alloc] init];
        _curveLayer.strokeColor = [UIColor greenColor].CGColor;
        _curveLayer.fillColor = [UIColor clearColor].CGColor;
//        绘制曲线
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 350)];
//        第一个参数是终点位置；第二个参数是第一个控制点；第三个参数是第二个控制点
        [path addCurveToPoint:CGPointMake(250, 350) controlPoint1:CGPointMake(100, 250) controlPoint2:CGPointMake(200, 450)];
        _curveLayer.path = path.CGPath;
    }
    return _curveLayer;
}

/*圆环进度条*/
- (CAShapeLayer *)animationLayer
{
    if(!_animationLayer){
        
        _animationLayer = [[CAShapeLayer alloc] init];
        _animationLayer.strokeColor = [UIColor blueColor].CGColor;
        _animationLayer.fillColor = [UIColor clearColor].CGColor;
        _animationLayer.lineWidth = 10;
//        绘制曲线，也就是动画路径
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kWidth/2-50, 460, 100, 100)];
//        创建动画，keyPath为指定的路劲，有专门的字符串，自己定义的字符串是不起作用的
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        动画起点
        animation.fromValue = @(0);
//        动画终点
        animation.toValue = @(1);
//        动画时间
        animation.duration = 3.0;
//        动画执行次数
        animation.repeatCount = 100;
        
        _animationLayer.path = path.CGPath;
        [_animationLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
    return _animationLayer;
}


/*直线进度条*/
- (CAShapeLayer *)lineAnimationLayer
{
    if(!_lineAnimationLayer){
        _lineAnimationLayer = [CAShapeLayer layer];
        _lineAnimationLayer.strokeColor = [UIColor greenColor].CGColor;
        _lineAnimationLayer.lineWidth = 5;
//        设置路径
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(50, 200)];
        [path addLineToPoint:CGPointMake(300, 200)];
        _lineAnimationLayer.path = path.CGPath;
        /*动画,keyPath是系统定的关键词，可以自己去帮助文档里面查看*/
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//        animation的动画时长
        animation.duration = 4.0;
//        动画的其实位置
        animation.fromValue = @(0);
        
//        动画的结束位置
        animation.toValue = @(1);
//        动画执行次数
        animation.repeatCount = MAXFLOAT;
//        添加动画并设置key；这个key值是自己定义的
        [_lineAnimationLayer addAnimation:animation forKey:@"lineAnimationLayer"];
    
    }
    return _lineAnimationLayer;
}


/**
 配置贝塞尔曲线
 
 @param startPoint 起始点
 @param endPoint 结束点
 @param controlPoint 控制点
 @return UIBezierPath对象
 */
- (UIBezierPath *)startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    return path;
}


/**
 *注水动画效果图
 * 首先底部是一张默认图，也就是没有填充的图片
 * 在默认图同样的位置上，在放置一张和默认图一样的填充图，覆盖默认图
 * 设置填充图greenImageView的layer.mask为一个CALayer的类layer
 * 将animationUp和animationDown添加到layer上面
 * 创建动画路劲，分别为up和down的路径
 * 执行动画
 */

/*grayImageView*/
- (UIImageView *)grayImageView
{
    if(!_grayImageView){
        _grayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bull_head_gray"]];
        _grayImageView.frame = CGRectMake(0, 0, 60, 60);
        _grayImageView.center = CGPointMake(kWidth/2, kHeight/2);
        [self addSubview:_grayImageView];
    }
    return _grayImageView;
}

/*grayImageView*/
- (UIImageView *)greenImageView
{
    if(!_greenImageView){
        _greenImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bull_head_green"]];
        _greenImageView.frame = CGRectMake(0, 0, 60, 60);
        _greenImageView.center = CGPointMake(kWidth/2, kHeight/2);
        [self addSubview:_greenImageView];
    }
    return _greenImageView;
}

/**
 *创建greenImageView的layer.mask
 */
-(CALayer *)greenHeadMaskLayer{
    CALayer * mask = [CALayer layer];
    mask.frame = self.greenImageView.bounds;
    
//    实现animationUP
    self.animationUp = [CAShapeLayer layer];
    self.animationUp.bounds = CGRectMake(0, 0, 60.f, 60.f);
    self.animationUp.position = CGPointMake(-5.f, -5.f);
    self.animationUp.fillColor = [UIColor greenColor].CGColor;
    self.animationUp.opacity = 0.8;
    self.animationUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.f, 30.f) radius:30.f startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    [mask addSublayer:self.animationUp];
    
    //    实现animationDown
    self.animationDown = [CAShapeLayer layer];
    self.animationDown.bounds = CGRectMake(0, 0, 60.f, 60.f);
    self.animationDown.position = CGPointMake(65.f, 65.f);
    self.animationDown.fillColor = [UIColor greenColor].CGColor;
    self.animationDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.f, 30.f) radius:30.f startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    [mask addSublayer:self.animationDown];
    
    return mask;
}

/*开始动画*/
-(void)startAnimation{
    /*up 动画属性*/
    CABasicAnimation * up = [CABasicAnimation animationWithKeyPath:@"position"];
    up.duration = 3.0;
    up.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5, -5)];
    up.toValue = [NSValue valueWithCGPoint:CGPointMake(30.f, 30.f)];
    up.repeatCount = MAXFLOAT;
    [self.animationUp addAnimation:up forKey:@"animationUp"];
    
    /*down 动画属性*/
    CABasicAnimation * down = [CABasicAnimation animationWithKeyPath:@"position"];
    down.duration = 3.0;
    down.fromValue = [NSValue valueWithCGPoint:CGPointMake(65.f, 65.f)];
    down.toValue = [NSValue valueWithCGPoint:CGPointMake(30.f, 30.f)];
    down.repeatCount = MAXFLOAT;
    [self.animationDown addAnimation:down forKey:@"animationDown"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self.layer addSublayer:self.lineLayer];
//        [self.layer addSublayer:self.circleLayer];
//        [self.layer addSublayer:self.radianLayer];
//        [self.layer addSublayer:self.curveLayer];
//        [self.layer addSublayer:self.animationLayer];
//        [self.layer addSublayer:self.lineAnimationLayer];
        [self grayImageView];
        self.greenImageView.layer.mask = [self greenHeadMaskLayer];
        [self startAnimation];
    }
    return self;
}

@end
