//
//  ReplicatorLayer.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/15.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ReplicatorLayer.h"



@implementation ReplicatorLayer

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.clipsToBounds = YES;
//        [self cicleReplicatorLayer];
//        [self radarAnimation];
//        [self circleAnimation];
        [self cicleScaleAnimation];
//        [self marquee];
//        [self marquee2];
//        [self marquee3];
    }
    return self;
}

/**
 * @func 重复图层圆形
 */
-(void)cicleReplicatorLayer{
    //创建一个ReplicatorLayer
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    //设置大小
    replicatorLayer.frame = self.bounds;
    [self.layer addSublayer:replicatorLayer];
    
    //设置ReplicatorLayer的复制个数
    replicatorLayer.instanceCount = 10;
    //给每个instance添加transform
    CATransform3D transform = CATransform3DIdentity;
    //向下平移200
//    transform = CATransform3DTranslate(transform, 50, 0, 0);
    //绕着Z轴旋转
    transform = CATransform3DRotate(transform, M_PI/5.0, 0, 0, 1);
    //上移200
    transform = CATransform3DTranslate(transform, -50, 50, 0);
    replicatorLayer.instanceTransform = transform;
    //添加渐变颜色
    replicatorLayer.instanceBlueOffset = -0.1;
    replicatorLayer.instanceGreenOffset = -0.1;
    //设置subLayer和位置大小
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(50, 100, 50, 50);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:layer];
}

/**
 *雷达动画
 */
-(void)radarAnimation{
//    创建一个shaperLayer图层，也就是做变大动画
    CAShapeLayer * shaperLayer = [CAShapeLayer layer];
    shaperLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shaperLayer.bounds = CGRectMake(0, 0, 20, 20);
    shaperLayer.cornerRadius = 10;
    shaperLayer.position = CGPointMake(kWidth/2, kHeight/2);
//    创建动画,缩放动画
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
    NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeScale(10, 10, 1)];
    transform.toValue = value;
    transform.duration = 3;
    transform.repeatCount = MAXFLOAT;
    //设置透明度，可以直接设置replicatorLayer的instanceAlphaOffset来设置
    CABasicAnimation * alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1);
    alpha.toValue = @(0);
    alpha.duration = 2;
//    创建动画组
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[transform,alpha];
    group.duration = 2;
    group.repeatCount = MAXFLOAT;
    [shaperLayer addAnimation:group forKey:@"radarAnimation"];
//    创建replicatorLayer
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    [replicatorLayer addSublayer:shaperLayer];
//    复制层的个数
    replicatorLayer.instanceCount = 3;
//    复制层延迟时间
    replicatorLayer.instanceDelay = 0.5;
//    replicatorLayer.instanceAlphaOffset = -0.1;
    [self.layer addSublayer:replicatorLayer];
}

/**
 *@func 圆点转圈动画效果
 */
-(void)circleAnimation{
//    创建shaperLayer。动画layer
    CAShapeLayer * shaperLayer = [CAShapeLayer layer];
    shaperLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shaperLayer.bounds = CGRectMake(0, 0, 20, 20);
    shaperLayer.cornerRadius = 10;
    shaperLayer.position = CGPointMake(kWidth/2, kHeight/2);
//    创建动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, CGRectMake((kWidth-160)/2, (kHeight-160)/2, 160, 160));
//    path和path1路径展示效果是一致的，两种方法都是绘制椭圆方法；
    UIBezierPath * path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((kWidth-160)/2, (kHeight-160)/2, 160, 160)];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake((kWidth-300)/2, (kHeight-200)/2, 300, 200)];
    
    CAKeyframeAnimation *transform = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    transform.duration = 4;
    transform.repeatCount = MAXFLOAT;
    transform.path = path2.CGPath;
    
    
    [shaperLayer addAnimation:transform forKey:nil];
    
//    创建replicatorLayer
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    [replicatorLayer addSublayer:shaperLayer];
    replicatorLayer.repeatCount = MAXFLOAT;
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceAlphaOffset = -0.1;
    [self.layer addSublayer:replicatorLayer];
}

/**
 * @func 转圈动画，带大小缩放
 */
-(void)cicleScaleAnimation{
    //创建一个shaperLayer,动画效果layer
    CAShapeLayer * shaperLayer = [CAShapeLayer layer];
    shaperLayer.backgroundColor = [UIColor whiteColor].CGColor;
    shaperLayer.bounds = CGRectMake(0, 0, 20, 20);
    shaperLayer.cornerRadius = 10;
    shaperLayer.position = CGPointMake(kWidth/2, 100);
    shaperLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    //创建缩放动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 2;
    animation.repeatCount = MAXFLOAT;
    //动画起始为原来大小
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    //动画结束为原来的0.1倍
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    [shaperLayer addAnimation:animation forKey:nil];
    
    //创建replicatorLayer
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    //这里设置的高度500，显示区域Y值在100-（500-100）之间，动画占用区域高度为300
    replicatorLayer.frame = CGRectMake(0, 0, kWidth, 500);
    [replicatorLayer addSublayer:shaperLayer];
    //重复层的个数
    replicatorLayer.instanceCount = 20;
    //重复出的延时
    replicatorLayer.instanceDelay = 0.1;
    CGFloat angle = 2*M_PI / 20.0;
    //创建replicatorLayer的instance的transform绕着Z轴旋转angle角度
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [self.layer addSublayer:replicatorLayer];
}

/**
 * 跑马灯
 */
-(void)marquee{
    //创建shaperLayer
    CAShapeLayer * shaperLayer = [CAShapeLayer layer];
    shaperLayer.bounds = CGRectMake(0, 0, 5, 3);
    shaperLayer.position = CGPointMake(kWidth/2, kHeight/2);
//    shaperLayer.lineWidth = 5;
    shaperLayer.backgroundColor = [UIColor whiteColor].CGColor;
//    [self.layer addSublayer:shaperLayer];
    
    //创建gradientLayer
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 10, 3);
    gradientLayer.colors = @[CGColorToNSObject([UIColor redColor]),CGColorToNSObject([UIColor blueColor]),CGColorToNSObject([UIColor greenColor])];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
//    gradientLayer.mask = shaperLayer;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake((kWidth-300)/2, (kHeight-200)/2, 300, 200)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 4;
    animation.repeatCount = MAXFLOAT;
    animation.path = path.CGPath;
    
    [shaperLayer addAnimation:animation forKey:nil];
    
    
    //创建replicatorLayer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
//    replicatorLayer.frame = self.bounds;
    [replicatorLayer addSublayer:shaperLayer];
    replicatorLayer.repeatCount = MAXFLOAT;
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.1;
    replicatorLayer.instanceAlphaOffset = -0.1;
    [self.layer addSublayer:replicatorLayer];

}


/**
 * 跑马灯二（shaperLayer）
 */
-(void)marquee2{
    //创建一个shaperLayer
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.bounds = CGRectMake(0, 0, 10, 5);
    shaperLayer.position = CGPointMake((kWidth-300)/2, (kHeight-200)/2);
    shaperLayer.strokeColor = [UIColor whiteColor].CGColor;
    shaperLayer.fillColor = [UIColor clearColor].CGColor;
    shaperLayer.lineDashPattern = @[@(10),@(10)];
//    虚线结尾处的类型
    shaperLayer.lineCap = kCALineCapRound;
//    拐角处layer的类型
    shaperLayer.lineJoin = kCALineJoinRound;
    shaperLayer.lineWidth = 5;
    
    //创建动画路径
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 300, 200)];
    shaperLayer.path = path.CGPath;
//    CGPathRelease(path.CGPath);
    
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.duration = 8;
    animation2.repeatCount = MAXFLOAT;
    animation2.values = @[@(0),@(1),@(0)];
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    
    /**
     * 上述的animation2的动画和效果和下面的animation动画效果是一样的
     */
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 4;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = @(0);
    animation.toValue = @(1);
//    这个设置是在一个动画完成时，是否需要反向动画，默认是NO
    animation.autoreverses = YES;
    
    [shaperLayer addAnimation:animation forKey:nil];
    
    [self.layer addSublayer:shaperLayer];
}

/**
 * 跑马灯三
 */

/*无到有的shaper*/
- (CAShapeLayer *)shaperLayer1
{
    if(!_shaperLayer1){
        _shaperLayer1 = [CAShapeLayer layer];
        //    shaperLayer1.position = CGPointMake((kWidth-300)/2, (kHeight-200)/2);
        _shaperLayer1.strokeColor = [UIColor whiteColor].CGColor;
        _shaperLayer1.fillColor = [UIColor clearColor].CGColor;
        _shaperLayer1.lineDashPattern = @[@(8)];
        //    结尾处的类型
        _shaperLayer1.lineCap = kCALineCapRound;
        //    拐角处的类型
        _shaperLayer1.lineJoin = kCALineJoinRound;
        _shaperLayer1.lineWidth = 5;
    }
    return _shaperLayer1;
}
/*有到无shaper*/
- (CAShapeLayer *)shaperLayer2
{
    if(!_shaperLayer2){
        _shaperLayer2 = [CAShapeLayer layer];
        //    shaperLayer2.position = CGPointMake((kWidth-300)/2, (kHeight-200)/2);
        _shaperLayer2.strokeColor = [UIColor whiteColor].CGColor;
        _shaperLayer2.fillColor = [UIColor clearColor].CGColor;
        _shaperLayer2.lineDashPattern = @[@(8)];
        //    结尾处的类型
        _shaperLayer2.lineCap = kCALineCapRound;
        //    拐角处的类型
        _shaperLayer2.lineJoin = kCALineJoinRound;
        _shaperLayer2.lineWidth = 5;
    }
    return _shaperLayer2;
}

/*注释*/
- (CABasicAnimation *)animation1
{
    if(!_animation1){
        _animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation1.duration = 4;
        _animation1.fromValue = @(0);
        _animation1.toValue = @(1);
        _animation1.repeatCount = 1;
        _animation1.removedOnCompletion = NO;
        _animation1.fillMode = kCAFillModeForwards;
        _animation1.delegate = self;
        [_animation1 setValue:@"animation1" forKey:@"animation1"];
    }
    return _animation1;
}

/*注释*/
- (CABasicAnimation *)animation2
{
    if(!_animation2){
        _animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation2.fromValue = @(1);
        _animation2.toValue = @(0);
        _animation2.duration = 4;
        _animation2.repeatCount = 1;
//        _animation2.autoreverses = YES;
        _animation2.removedOnCompletion = NO;
        _animation2.fillMode = kCAFillModeBackwards;
        _animation2.delegate = self;
        [_animation2 setValue:@"animation2" forKey:@"animation2"];
    }
    return _animation2;
}

- (void)marquee3{
//    创建路径
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(20, 200)];
    [path1 addLineToPoint:CGPointMake(300, 200)];
    [path1 addLineToPoint:CGPointMake(300, 400)];
    [path1 addLineToPoint:CGPointMake(20, 400)];
    [path1 closePath];
    self.shaperLayer1.path = path1.CGPath;
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(20, 200)];
    [path2 addLineToPoint:CGPointMake(20, 400)];
    [path2 addLineToPoint:CGPointMake(300, 400)];
    [path2 addLineToPoint:CGPointMake(300, 200)];
    [path2 closePath];
    self.shaperLayer2.path = path2.CGPath;
//    创建动画
    [self.shaperLayer1 addAnimation:self.animation1 forKey:@"animation1"];
    
    [self.layer addSublayer:self.shaperLayer1];
    [self.layer addSublayer:self.shaperLayer2];
    self.shaperLayer2.opacity = 0;
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if ([[anim valueForKey:@"animation1"] isEqualToString:@"animation1"]) {
        self.shaperLayer1.opacity = 0;
        [self.shaperLayer1 removeAnimationForKey:@"animation1"];
        [self.shaperLayer2 addAnimation:self.animation2 forKey:@"animation2"];
        self.shaperLayer2.opacity = 1;
    }else{
        self.shaperLayer2.opacity = 0;
        [self.shaperLayer2 removeAllAnimations];
        [self.shaperLayer1 addAnimation:self.animation1 forKey:@"animation1"];
        self.shaperLayer1.opacity = 1;
    }
}


@end
