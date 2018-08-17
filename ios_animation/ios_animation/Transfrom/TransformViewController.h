//
//  TransformViewController.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/14.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransformViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;
- (IBAction)click:(UIButton *)sender;

@end
