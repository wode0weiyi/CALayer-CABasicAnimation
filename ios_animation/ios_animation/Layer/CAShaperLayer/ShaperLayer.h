//
//  ShaperLayer.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//


/*
 * CAShapeLayer属性解释：
 *
 ** @property(nullable) CGPathRef path;
    呈现的形状的路径。赋值时，路径被复制。默认为null
 ** @property(nullable) CGColorRef fillColor;
    填充路径的颜色，或不需要填充。默认颜色为不透明的黑色。
 ** @property(copy) NSString *fillRule;
    当在填充颜色的时候则就需要这种填充规则，值有两种，非零和奇偶数，但默认是非零值。
 ** @property(nullable) CGColorRef strokeColor;
    设置描边色，默认无色。
 ** @property CGFloat strokeStart; @property CGFloat strokeEnd;
    这两个值被定义用于绘制边线轮廓路径的子区域。该值必须在[0,1]范围，0代表路径的开始，1代表路径的结束。在0和1之间的值沿路径长度进行线性插值。strokestart默认为0，strokeend默认为1。
 ** @property CGFloat lineWidth;
    lineWidth为线的宽度，默认为1；
 ** @property CGFloat miterLimit;
    miterLimit为最大斜接长度。斜接长度指的是在两条线交汇处和外交之间的距离。只有lineJoin属性为kCALineJoinMiter时miterLimit才有效。边角的角度越小，斜接长度就会越大。为了避免斜接长度过长，我们可以使用miterLimit属性。如果斜接长度超过miterLimit的值，边角会以lineJoin的“bevel”即kCALineJoinBevel类型来显示。
 ** @property(copy) NSString *lineCap;
    lineCap为线端点类型，值有三个类型，分别为kCALineCapButt 、kCALineCapRound 、kCALineCapSquare，默认值为Butt；
 ** @property(copy) NSString *lineJoin;
    lineJoin为线连接类型，其值也有三个类型，分别为kCALineJoinMiter、kCALineJoinRound、kCALineJoinBevel，默认值是Miter
 ** @property CGFloat lineDashPhase;
    lineDashPhase为线型模版的起始位置
 ** @property(nullable, copy) NSArray<NSNumber *> *lineDashPattern;
    lineDashPattern为线性模版，这是一个NSNumber的数组，索引从1开始记，奇数位数值表示实线长度，偶数位数值表示空白长度。
 
 */



#import <UIKit/UIKit.h>

@interface ShaperLayer : UIView
/*定义CAShapeLayer*/
@property (nonatomic,strong) CAShapeLayer *lineLayer;
/*圆CAShapeLayer*/
@property (nonatomic,strong) CAShapeLayer *circleLayer;
/*弧度CAShapeLayer*/
@property (nonatomic,strong) CAShapeLayer *radianLayer;
/*曲线CAShapeLayer*/
@property (nonatomic,strong) CAShapeLayer *curveLayer;
/*动画CAShapeLayer*/
@property (nonatomic,strong) CAShapeLayer *animationLayer;
/*直线进度条*/
@property (nonatomic,strong) CAShapeLayer *lineAnimationLayer;

/**
 *注水动画效果属性
 */
/*注水动画需要的灰色图*/
@property (nonatomic,strong) UIImageView *grayImageView;
/*注水动画需要的填充图*/
@property (nonatomic,strong) UIImageView *greenImageView;
/*注水动画上半部分的layer*/
@property (nonatomic,strong) CAShapeLayer *animationUp;
/*注水动画的下半部分的layer*/
@property (nonatomic,strong) CAShapeLayer *animationDown;

@end
