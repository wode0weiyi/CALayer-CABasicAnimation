//
//  ReplicatorLayer.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/15.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplicatorLayer : UIView<CAAnimationDelegate>
/*第一个shaperLayer*/
@property (nonatomic,strong) CAShapeLayer *shaperLayer1;
/*第二个shaperLayer*/
@property (nonatomic,strong) CAShapeLayer *shaperLayer2;
/*第一个shaperLayer的动画*/
@property (nonatomic,strong) CABasicAnimation *animation1;
/*第二个shaperLayer的动画*/
@property (nonatomic,strong) CABasicAnimation *animation2;
@end
