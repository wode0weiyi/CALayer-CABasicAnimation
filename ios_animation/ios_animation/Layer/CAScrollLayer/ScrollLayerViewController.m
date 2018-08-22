//
//  ScrollLayerViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/21.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ScrollLayerViewController.h"
#import "ScrollLayer.h"

@interface ScrollLayerViewController ()

@end

@implementation ScrollLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"scrollLayer";
    
    //创建一个layer展示内容层，也就是scrollLayer的子视图
    CALayer * layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 300, 300);
    layer.position = CGPointMake(150, 100);
    layer.contents = (__bridge id)[UIImage imageNamed:@"reflection_image"].CGImage;
    
    //创建自定义的scrollLayer的view
    ScrollLayer *scrollLayer = [[ScrollLayer alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    scrollLayer.layer.borderColor = [UIColor grayColor].CGColor;
    scrollLayer.layer.borderWidth = 1;
    
    scrollLayer.center = CGPointMake(kWidth/2, kHeight/2);
    [scrollLayer.layer addSublayer:layer];
    [self.view addSubview:scrollLayer];
}


@end
