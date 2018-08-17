//
//  TransformViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/14.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "TransformViewController.h"
#import <GLKit/GLKit.h>

#define kLength (150/2)

@interface TransformViewController ()

@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*
    //set self view sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
////    //绕着X轴向左旋转45度
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
////    //绕着Y轴向下旋转45度
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.view.layer.sublayerTransform = perspective;
    
    [self transforms];
 
 */
 

//    CATransformLayer
//    创建第一个cube
    CATransform3D ct1 = CATransform3DIdentity;
    //x轴位移
    ct1 = CATransform3DTranslate(ct1, -100, 0, 0);
    ct1.m34 = -1.0/500;
    //创建cube的六个面
    CALayer * cube1 = [self cubeWithTransform:ct1];
    [self.view.layer addSublayer:cube1];
    
//    创建第二个cube
    CATransform3D ct2 = CATransform3DIdentity;
    //x轴平移100
    ct2 = CATransform3DTranslate(ct2, 100, 0, 0);
    //绕着X轴旋转-45
    ct2 = CATransform3DRotate(ct2, -M_PI_4, 1, 0, 0);
    //绕着Y轴旋转-45
    ct2 = CATransform3DRotate(ct2, -M_PI_4, 0, 1, 0);
    CALayer * cube2 = [self cubeWithTransform:ct2];
    [self.view.layer addSublayer:cube2];
 
}

//设置正方体的六个面的transform
-(void)transforms{
    /**
     *ios上坐标系规则为：x轴右边为正，y轴下边为正，z轴前面为正
     */
    //add cube face 1(正方体前面)
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, kLength);
    [self addFace:0 withTransform:transform];
    //add cube face 2（正方体右面）
    transform = CATransform3DMakeTranslation(kLength, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 4(正方体下面)
    transform = CATransform3DMakeTranslation(0, kLength, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5(正方体左边)
    transform = CATransform3DMakeTranslation(-kLength, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6(正方体后面）
    transform = CATransform3DMakeTranslation(0, 0, -kLength);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    //add cube face 3（正方体上面）
    transform = CATransform3DMakeTranslation(0, -kLength, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
}

//将正方体的六个面添加到self.view上，并创建face.layer的transform
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    //get the face view and add it to the container”
    UIView * face = self.faces[index];
//如果添加face的时候，3号不是最后添加的话，则button的按钮点击事件会被拦截，虽然变换了位置；可以设置其他界面的userInteractionEnabled为NO；或者最后一个添加3号视图
//    if (index != 2) {
//        face.userInteractionEnabled = NO;
//    }
    [self.view addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.view.bounds.size;
    face.center = CGPointMake(containerSize.width/2, containerSize.height/2);
    //apply the transfrom
    face.layer.transform = transform;
    face.layer.borderWidth = .5;
}

//创建layer并设置背景色和transform
-(CALayer *)faceWithTransform:(CATransform3D)transform{
    CALayer * face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    CGFloat red = (rand()/(double)INT_MAX);
    CGFloat green = (rand()/(double)INT_MAX);
    CGFloat blue = (rand()/(double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    face.transform = transform;
    return face;
}

//创建transformLayer，并添加layer
-(CALayer*)cubeWithTransform:(CATransform3D)transform{
    //create cube layer
    CATransformLayer * cube = [CATransformLayer layer];
    //add cube face 1，Z轴位移50
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 2，Z轴位移-50，Y轴旋转M_PI
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 3,X轴位移50，Y轴旋转M_PI_2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 4,X轴位移-50，Y轴旋转-M_PI_2
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 5,Y轴位移50，X轴旋转M_PI_2
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    //add cube face 6,Y轴位移-50，X轴旋转-M_PI_2
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width/2.0, containerSize.height/2.0);
    cube.transform = transform;
    return cube;
}

- (IBAction)click:(UIButton *)sender {
    NSLog(@"clickButton");
}
@end
