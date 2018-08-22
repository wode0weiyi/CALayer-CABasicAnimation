//
//  ReflectionView.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/20.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ReflectionView.h"

@implementation ReflectionView

+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

-(void)setUp{
//    创建一个replicatorLayer
    CAReplicatorLayer * layer = (CAReplicatorLayer *)self.layer;
//    设置重复层个数
    layer.instanceCount = 2;

//    设置重复层的transform
    CATransform3D transform = CATransform3DIdentity;
//    设置位移量
    CGFloat verticalHeight = self.bounds.size.height + 2;
//    设置沿着Y轴位移verticalHeight
    transform = CATransform3DTranslate(transform, 0, verticalHeight, 0);
//    设置Y方向缩放-1，
    transform = CATransform3DScale(transform, 1, -1, 1);
//    transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
//    添加transform
    layer.instanceTransform = transform;
//    设置重复层的alpha变化
    layer.instanceAlphaOffset = -0.6;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

@end
