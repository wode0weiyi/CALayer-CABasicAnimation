//
//  StrokeView.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/1.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrokeView : UIView
/*注释*/
@property (nonatomic , assign) CGContextRef context;

- (void)animation:(CGFloat)persent;
@end
