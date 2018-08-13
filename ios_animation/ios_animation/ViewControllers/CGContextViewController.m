//
//  CGContextViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "CGContextViewController.h"
#import "StrokeView.h"

@interface CGContextViewController ()
/*注释*/
@property (nonatomic,strong) StrokeView *strokeView;
@end

@implementation CGContextViewController

/*注释*/
- (StrokeView *)strokeView
{
    if(!_strokeView){
        _strokeView = [[StrokeView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight)];
        [self.view addSubview:_strokeView];
    }
    return _strokeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self strokeView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
