//
//  ReflectionViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/20.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ReflectionViewController.h"
#import "ReflectionView.h"

@interface ReflectionViewController ()

@end

@implementation ReflectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"replicator反射效果";
    ReflectionView * view = [[ReflectionView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.center = CGPointMake(kWidth/2, kHeight/2-200);
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    img.image = [UIImage imageNamed:@"reflection_image"];
    [view addSubview:img];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
