//
//  ShowLayerViewController.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    CALayerLayer,
    CALayerShapeLayer,
    CALayerGradientLayer
} LayerType;

@interface ShowLayerViewController : UIViewController
/*需要展示的layer类型*/
@property (nonatomic , assign) LayerType layerType;
@end
