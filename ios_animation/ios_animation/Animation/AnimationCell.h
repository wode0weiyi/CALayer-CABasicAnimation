//
//  AnimationCell.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/1.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AnimationCell : UITableViewCell
/*注释*/
@property (nonatomic,strong) UIImageView *headerImage;
/*上半部分的CAGradientLayer*/
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
/*下半部分的CAGradientLayer*/
@property (nonatomic,strong) CAGradientLayer *gradientLayer2;
/*上半部分的半圆CAShapeLayer*/
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
/*下半部分的半圆CAShapeLayer*/
@property (nonatomic,strong) CAShapeLayer *shapeLayer2;

-(void)refreshButtonStartAnimation;
@end
