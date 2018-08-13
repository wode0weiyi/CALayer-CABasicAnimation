//
//  UIView_CALayer.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//




/**
 *CALayer的可动画属性称为Animatable Properties，这些属性包括：
 *bounds：用于设置CALayer的宽度和高度。修改这个属性会产生缩放动画
 *backgroundColor：用于设置CALayer的背景色。修改这个属性会产生背景色的渐变动画
 *position：用于设置CALayer的位置。修改这个属性会产生平移动画
 *anchorPoint:锚点指定了position在当前图层中的位置，坐标范围0~1。position点的值是相对于父图层的，而这个position到底位于当前图层的什么地方，是由锚点决定的。(默认在图层的中心，即锚点为(0.5,0.5) )
 */



#import <UIKit/UIKit.h>

@interface UIView_CALayer : UIView
/*定义CALayer属性,position为(100，100) anchorPoint为默认值(0.5,0.5)*/
@property (nonatomic,strong) CATextLayer *myLayer;
/*position为(100，200)，anchorPoint为(0,0)*/
@property (nonatomic,strong) CATextLayer *myLayer1;
/*position为(100，300)，anchorPoint为(1,1)*/
@property (nonatomic,strong) CATextLayer *myLayer2;
/*随touch点移动的animationLayer*/
@property (nonatomic,strong) CALayer *animationLayer;
/*显示图片的layer*/
@property (nonatomic,strong) CALayer *imageLayer;
@end
