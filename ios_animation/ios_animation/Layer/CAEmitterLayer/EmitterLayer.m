//
//  EmitterLayer.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/21.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "EmitterLayer.h"

@implementation EmitterLayer

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self snow];
        [self emitter];
    }
    return self;
}

/**
 * 下雪的效果（下雨）
 */
-(void)snow{
    //创建一个CAEmitterLayer
    CAEmitterLayer * emitterLayer = [CAEmitterLayer layer];
    //发射位置
    emitterLayer.emitterPosition = CGPointMake(kWidth/2, 0);
    //发射源的尺寸
    emitterLayer.emitterSize = CGSizeMake(kWidth, 1);
    //发射源的形状
    emitterLayer.emitterMode = kCAEmitterLayerSurface;
    //发射模式
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    
    //初始化CAEmitterCell
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    //cell的名字
    cell.name = @"snow";
    //粒子频率
    cell.birthRate = 2;
    //生命周期
    cell.lifetime = 30.f;
    //速度
    cell.velocity = 3.0f;
    //速度浮动值
    cell.velocityRange = 10.f;
    //发射角度浮动值
    cell.yAcceleration = 0.5 * M_PI;
    //自旋转角度浮动值
    cell.spinRange = 0.2 * M_PI;
    //粒子透明度在生命周期内的改变速度
    cell.alphaSpeed = 2.0;
    //cell的内容
    cell.contents = (__bridge id)[UIImage imageNamed:@"snow"].CGImage;
    
    emitterLayer.shadowOffset = CGSizeMake(3, 3);
    emitterLayer.shadowColor = [UIColor grayColor].CGColor;
    emitterLayer.shadowOpacity = 0.8;
    emitterLayer.emitterCells = @[cell];
    
    [self.layer addSublayer:emitterLayer];
}

/**
 * 粒子发射效果
 * 要实现有一圈扩散出去的效果，要在cells在没有全部生成之前，停止掉layer的动画，设置birthRate=0就可以了
 */
-(void)emitter{
    //初始化一个CAEmitterLayer
    CAEmitterLayer * layer = [CAEmitterLayer layer];
    //设置发射位置
    layer.emitterPosition = CGPointMake(kWidth/2, kHeight/2);
    //设置发射源的大小
    layer.emitterSize = CGSizeMake(30, 30);
    //设置发射源的类型
    layer.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    layer.renderMode = kCAEmitterLayerOldestFirst;
    //设置发射源粒子活动样式
    layer.emitterShape = kCAEmitterLayerCircle;
    layer.beginTime = CACurrentMediaTime();
    layer.birthRate = 1;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        layer.birthRate = 0;
    });
    
    //初始化CAEmitterCell
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    //设置每秒的粒子数量
    cell.birthRate = 2000;
    //设置周期时长
    cell.lifetime = 1.0;
    //设置周期时长浮动值
//    cell.lifetimeRange = 1.0;
    //粒子的名称
    cell.name = @"emitter";
    //粒子的速度
    cell.velocity = 10.0f;
    //粒子速度的浮动值
//    cell.velocityRange = 4.0f;
    //粒子的透明度变化值
    cell.alphaSpeed = -0.1;
    cell.scale = 0.05;
//    cell.scaleSpeed = -0.1;
    cell.contents = (__bridge id)[UIImage imageNamed:@"snow"].CGImage;
    
    layer.emitterCells = @[cell];
    
    [self.layer addSublayer:layer];
}

@end
