//
//  StrokeView.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/1.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "StrokeView.h"
#import <OpenGLES/ES2/gl.h>

@implementation StrokeView


- (instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.context = UIGraphicsGetCurrentContext();
//    绘制一条直线
//    [self strokeLine];
//    绘制贝兹曲线
//    [self strokeCurveLine];
//    绘制连续的贝兹曲线
//    [self strokeCurveLine2];
//    绘制曲线
//    [self strokeDash];
//    绘制虚曲线
//    [self strokeDashDurveLine];
//    绘制弧线
//    [self strokeArc];
//    绘制方框
//    [self strokeArc2];
//    绘制椭圆
//    [self strokeArc3];
//    绘制圆角矩形
//    [self stokeRadiusArc];
//    绘制圆形
//    [self strokeYuan];
    
}

/**
 *画一条直线
 */
-(void)strokeLine{
    //    线条颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
    //    线条宽度
    CGContextSetLineWidth(_context, 2);
    //    开始画线，x y 为开始点的坐标
    CGContextMoveToPoint(_context, 50, 70);
    //    结束画线，x y 为结束点的坐标
    CGContextAddLineToPoint(_context, 300, 80);
    //    开始画线
    CGContextStrokePath(_context);
}

/**
 *绘制贝兹曲线
 *贝兹曲线是通过移动一个起始点，然后通过两个控制点,还有一个中止点，调用CGContextAddCurveToPoint() 函数绘制
 */
-(void)strokeCurveLine{
//   设置线条宽度
    CGContextSetLineWidth(_context, 2);
//    设置线条颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
//    设置起始点
    CGContextMoveToPoint(_context, 60,70);
//    设置控制点，终止点
    CGContextAddCurveToPoint(_context, 200, 50, 100, 400, 300, 400);
//    开始绘画
    CGContextStrokePath(_context);
}

/**
 *绘制连续的曲线(❤️）
 */
-(void)strokeCurveLine2{
//    设置线条颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
//    设置线条宽度
    CGContextSetLineWidth(_context, 2);
//    设置起始点
    CGContextMoveToPoint(_context, 200, 190);
//    画三点曲线
    CGContextAddCurveToPoint(_context, 100, 120, 150, 70, 200, 120);
//    画三点曲线
    CGContextAddCurveToPoint(_context, 250, 70, 300, 120, 200, 190);
//    开始画线
    CGContextStrokePath(_context);
}
/**
 *绘制虚线
 */
-(void)strokeDash{
    //设置线条颜色
    CGContextSetRGBStrokeColor(_context, 0.1, 0.2, 0.3, 1);
//    设置虚线的长度3和虚线之间的间隔2
    CGFloat dashArray[] = {3,2};
//    画曲线
    CGContextSetLineDash(_context, 0, dashArray, 2);
//    设置起始点
    CGContextMoveToPoint(_context, 100, 200);
//    设置结束点
    CGContextAddLineToPoint(_context, 300, 200);
//    开始画线
    CGContextStrokePath(_context);
}

/**
 *绘制虚曲线
 */
-(void)strokeDashDurveLine{
    //设置线条颜色
    CGContextSetRGBStrokeColor(_context, 0.1, 0.2, 0.3, 1);
    CGFloat dashArray[] = {3,2};
    //    画曲线
    CGContextSetLineDash(_context, 0, dashArray, 2);
    //    设置起始点
    CGContextMoveToPoint(_context, 100, 200);
    //    设置曲线点
    CGContextAddCurveToPoint(_context, 150, 300, 200,100 , 250, 300);
    //    开始画线
    CGContextStrokePath(_context);
}

/**
 *绘制一个弧线，没有边框
 */
-(void)strokeArc{
//    设置线条颜色
    CGContextSetRGBStrokeColor(_context, 0.3, 0.4, 0.5, 1);
//    设置填充色
    CGContextSetRGBFillColor(_context, 0, 0.25, 0, 1);
//    画弧线
    CGContextAddArc(_context, 180, 200, 50, 0, 180*(M_PI/180), 0);
//    绘制
    CGContextStrokePath(_context);
}

/**
 *绘制方形边框
 */
-(void)strokeArc2{
//    设置线条颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
//    设置线条宽度
    CGContextSetLineWidth(_context, 2);
//    绘制
    CGContextStrokeRect(_context, CGRectMake(100, 100, 100, 100));
}
/**
 *绘制椭圆
 */
-(void)strokeArc3{
//    设置线条颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
//    设置线条宽度
    CGContextSetLineWidth(_context, 2);
//    绘制,
/** CGContextAddEllipseInRect参数说明：
 * 第一个是CGContextRef对象
 * 第二个参数是椭圆大小，x是表示椭圆左边距离边框位置，y是表示椭圆上边距离边框位置，w表示椭圆宽度，h表示椭圆高度
 */
    CGContextAddEllipseInRect(_context, CGRectMake(80, 80, 200, 100));
    CGContextDrawPath(_context, kCGPathStroke);
}
/**
 *绘制圆角矩形
 */
-(void)stokeRadiusArc{
    CGFloat fw = 180;
    CGFloat fh = 280;
//    设置线条颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
//    设置线条宽度
    CGContextSetLineWidth(_context, 2);
//    创建起始点
    CGContextMoveToPoint(_context, fw, fh+20);
//    创建圆角
    CGContextAddArcToPoint(_context, fw, fh, fw+20, fh, 10);
    CGContextAddArcToPoint(_context, 240, fh, 240, fh+20, 10);
    CGContextAddArcToPoint(_context, 240, 310, fw+40, 310, 10);
    CGContextAddArcToPoint(_context, fw, 310, fw, fh+10, 10);
//    关闭曲线
    CGContextClosePath(_context);
//    绘制
    CGContextDrawPath(_context, kCGPathFillStroke);
}
/**
* 绘制圆形
 */
-(void)strokeYuan{
    //设置线条颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
//    设置宽度
    CGContextSetLineWidth(_context, 3);
//    设置无填充圆形
    CGContextAddArc(_context, 200, 200, 50, 0, 2*M_PI, 0);
//    绘制
    CGContextStrokePath(_context);
    
//    设置填充圆
    CGContextAddArc(_context, 100, 200, 50, 0, 2*M_PI, 0);
//    绘制
    CGContextDrawPath(_context, kCGPathFill);
    
//    设置有边框的填充圆
    UIColor * color = [UIColor yellowColor];
//    设置填充颜色
    CGContextSetFillColorWithColor(_context, color.CGColor);
//    设置边框宽度
    CGContextSetLineWidth(_context, 10);
//    设置圆数据
    CGContextAddArc(_context, 200, 320, 50, 2*M_PI, 0, 1);
    //    绘制(kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充)
    CGContextDrawPath(_context, kCGPathFillStroke);
}

- (void)animation:(CGFloat)persent{
    //设置圆形的颜色
    CGContextSetStrokeColorWithColor(_context, [UIColor redColor].CGColor);
//    设置宽度
    CGContextSetLineWidth(_context, 3);
//    设置圆数据
    CGContextAddArc(_context, 200, 430, 50, 0, M_PI * persent, 0);
//    绘制
    CGContextDrawPath(_context, kCGPathStroke);
}

@end
