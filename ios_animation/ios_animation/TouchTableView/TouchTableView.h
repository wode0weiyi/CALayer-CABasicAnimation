//
//  TouchTableView.h
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/6.
//  Copyright © 2018年 胡志辉. All rights reserved.
//


/**
 *这个TouchTableView是针对在uitableview上面，进行手势操作的时候，一个是避免冲突，一个是避免tableview把touch事件截获掉
 *原理：通过代理协议将TableView的touchBegan、touchMoved、touchCanceled、touchEnd在viewController里面实现（有人说直接在viewController里面实现touchBegan等方法不就可以了？这里尝试过的朋友都不会这么说了，我是这么理解的，在viewController里面实现的touchBegan等方法是viewController.view的touch事件，而不是tableView的touch事件，所以以代理的方式把tableview的touchBegan方法传出去，让viewController实现）
 *也尝试过网上的其他方法，比如hitTest:event的方法，结果不可行；生成TableView的子类重写touchBegan，也是不行
 *如果针对tap事件和uitableview的cell点击冲突的情况，不需要这么复杂，只需要实现UIGestureRecognizerDelegate的- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;方法，在里面判断点击的是cell还是什么；
 */

#import <UIKit/UIKit.h>

@protocol TouchTableViewDelegate<NSObject>

@optional
- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event;

@end


@interface TouchTableView : UITableView
{
@private __weak id _touchDelegate;

}
/*注释*/
@property (nonatomic,weak) id<TouchTableViewDelegate> touchDelegate;
@end
