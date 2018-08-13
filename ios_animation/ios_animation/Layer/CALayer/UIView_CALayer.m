//
//  UIView_CALayer.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "UIView_CALayer.h"

@implementation UIView_CALayer

/*懒加载*/
- (CATextLayer *)myLayer
{
    if(!_myLayer){
        _myLayer = [[CATextLayer alloc] init];
        _myLayer.bounds = CGRectMake(0, 0, 100, 100);
        _myLayer.backgroundColor = [UIColor redColor].CGColor;
        _myLayer.position = CGPointMake(100, 100);
        _myLayer.anchorPoint = CGPointMake(0, 0);
        _myLayer.string = @"(0,0)";
        _myLayer.fontSize = 15.f;
        _myLayer.foregroundColor = [UIColor blackColor].CGColor;
    }
    return _myLayer;
}

/*懒加载*/
- (CATextLayer *)myLayer1
{
    if(!_myLayer1){
        _myLayer1 = [[CATextLayer alloc] init];
        _myLayer1.bounds = CGRectMake(0, 0, 100, 100);
        _myLayer1.backgroundColor = [UIColor yellowColor].CGColor;
        _myLayer1.position = CGPointMake(100, 100);
        _myLayer1.anchorPoint = CGPointMake(0, 1);
        _myLayer1.string = @"(0,1)";
        _myLayer1.fontSize = 15.f;
        _myLayer1.foregroundColor = [UIColor blackColor].CGColor;
    }
    return _myLayer1;
}

/*懒加载*/
- (CATextLayer *)myLayer2
{
    if(!_myLayer2){
        _myLayer2 = [[CATextLayer alloc] init];
        _myLayer2.bounds = CGRectMake(0, 0, 100, 100);
        _myLayer2.backgroundColor = [UIColor greenColor].CGColor;
        _myLayer2.position = CGPointMake(100, 100);
        _myLayer2.anchorPoint = CGPointMake(1, 0);
        _myLayer2.string = @"(1,0)";
        _myLayer2.fontSize = 15.f;
        _myLayer2.foregroundColor = [UIColor blueColor].CGColor;
    }
    return _myLayer2;
}

/*动画layer*/
- (CALayer *)animationLayer
{
    if(!_animationLayer){
        _animationLayer = [CALayer layer];
//        设置背景颜色
        _animationLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:1].CGColor;
//        设置中心点
        _animationLayer.position = CGPointMake(kWidth/2, kHeight/2);
//        设置大小
        _animationLayer.bounds = CGRectMake(0, 0, 100, 100);
//        设置圆角，当圆角半径等于大小的一半时，则显示出来的是圆形
        _animationLayer.cornerRadius = 50;
//        设置阴影
        _animationLayer.shadowColor = [UIColor grayColor].CGColor;
//        设置阴影偏移量
        _animationLayer.shadowOffset = CGSizeMake(3, 1);
//        设置阴影的透明度
        _animationLayer.shadowOpacity = 0.9;
//        设置边框
//        _animationLayer.borderColor = [UIColor whiteColor].CGColor;
//        设置边框大小
//        _animationLayer.borderWidth = 1;
//        设置锚点
//        _animationLayer.anchorPoint = CGPointZero;
        
    }
    return _animationLayer;
}

/*显示图层的layer*/
- (CALayer *)imageLayer
{
    if(!_imageLayer){
        _imageLayer = [CALayer layer];
//        设置大小
        _imageLayer.bounds = CGRectMake(0, 0, 100, 100);
//        设置position
        _imageLayer.position = CGPointMake(200, 100);
//        设置背景颜色
        _imageLayer.backgroundColor = [UIColor redColor].CGColor;
//        设置圆角
        _imageLayer.cornerRadius = 100/2;
//        如果要正确显示出图片，就要设置masksToBounds = YES，剪切子图层
        _imageLayer.masksToBounds = YES;
//        注意：阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，阴影刚好处于外边框
//        设置边框
        _imageLayer.borderColor = [UIColor yellowColor].CGColor;
//        设置边框宽度
        _imageLayer.borderWidth = 2;
        [self.layer addSublayer:_imageLayer];
        /**
         * 给图层设置图片内容，可以使用CALayerDelegate的- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx方法重绘，但是代理对象不能指定UIView的实例对象，如果指定的是UIView实例对象，则会导致cash。可以在Controller里面指定代理，然后实现代理方法重绘；要想代理方法实现，还必须调用 setNeedsDisplay 方法，否则代理方法不会调用
         * 如果只是单单的显示图片，设置layer的contents的内容就可以了！
         */
//        _imageLayer.contents = (__bridge id)[UIImage imageNamed:@"banner"].CGImage;
        
    }
    return _imageLayer;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
//    图形上下文形变，解决图片倒立问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -100);
    UIImage *img = [UIImage imageNamed:@"banner"];
//    注意这个位置是相对于图层而言而不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), img.CGImage);
    CGContextRestoreGState(ctx);
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    获取手指的点击事件的touch
    UITouch * touch = [touches anyObject];
//    获取当前layer的宽度
    CGFloat width = self.animationLayer.bounds.size.width;
//    设置宽度
    if (width == 100) {
        width = 2 * 100;
    }else{
        width = 100;
    }
    self.animationLayer.bounds = CGRectMake(0, 0, width, width);
//    设置position
    self.animationLayer.position = [touch locationInView:self];
//    设置圆角
    self.animationLayer.cornerRadius = width/2;
}

- (instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
//        [self.layer addSublayer:self.myLayer];
//        [self.layer addSublayer:self.myLayer1];
//        [self.layer addSublayer:self.myLayer2];
//        [self.layer addSublayer:self.animationLayer];
        [self imageLayer];
    }
    return self;
}

@end
