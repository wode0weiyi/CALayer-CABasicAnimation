//
//  ShowLayerViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ShowLayerViewController.h"
#import "UIView_CALayer.h"
#import "ShaperLayer.h"
#import "GradientLayer.h"
#import "ReplicatorLayer.h"

@interface ShowLayerViewController ()<CALayerDelegate>
/*注释*/
@property (nonatomic,strong) UIView_CALayer *layer;
/*注释*/
@property (nonatomic,strong) ShaperLayer *shaperLayer;
/*注释*/
@property (nonatomic,strong) GradientLayer *gradientLayer;
/*注释*/
@property (nonatomic,strong) ReplicatorLayer *replicatorLater;
@end

@implementation ShowLayerViewController

/*CALayer*/
- (UIView_CALayer *)layer
{
    if(!_layer){
        _layer = [[UIView_CALayer alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight)];
//CALayerDelegate的指定的代理对象不能是UIView的实例对象，否则会造成cash；
        _layer.imageLayer.delegate = self;
        [self.view addSubview:_layer];
//        如果不调用这个方法，则代理方法- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;不会调用
        [_layer.imageLayer setNeedsDisplay];
    }
    return _layer;
}

/*shaperLayer*/
- (ShaperLayer *)shaperLayer
{
    if(!_shaperLayer){
        _shaperLayer = [[ShaperLayer alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        [self.view addSubview:_shaperLayer];
    }
    return _shaperLayer;
}

/*gradientLayer*/
- (GradientLayer *)gradientLayer
{
    if(!_gradientLayer){
        _gradientLayer = [[GradientLayer alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight)];
        [self.view addSubview:_gradientLayer];
    }
    return _gradientLayer;
}

/*replicatorLater*/
- (ReplicatorLayer *)replicatorLater
{
    if(!_replicatorLater){
        _replicatorLater = [[ReplicatorLayer alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64)];
        [self.view addSubview:_replicatorLater];
    }
    return _replicatorLater;
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

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    if (self.layerType == CALayerLayer) {
        self.title = @"layer";
        [self layer];
    }else if (self.layerType == CALayerShapeLayer){
        self.title = @"shapeLayer";
        [self shaperLayer];
    }else if (self.layerType == CALayerGradientLayer){
        self.title = @"gradientLayer";
        [self gradientLayer];
    }else if (self.layerType == CALayerReplicatorLayer){
        self.title = @"replicatorLayer";
        [self replicatorLater];
    }
}


@end
