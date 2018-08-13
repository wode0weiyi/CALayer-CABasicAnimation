//
//  AnimationViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/1.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "AnimationViewController.h"
#import "AnimationCell.h"
#import "TouchTableView.h"

@interface AnimationViewController ()<UITableViewDelegate,UITableViewDataSource,TouchTableViewDelegate>
/*注释*/
@property (nonatomic,strong) TouchTableView *tableView;
/*注释*/
@property (nonatomic , assign) CGPoint beginPoint;
/*注释*/
@property (nonatomic,copy) NSString *animationDirection;
@end

@implementation AnimationViewController

/*注释*/
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[TouchTableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.touchDelegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[AnimationCell class] forCellReuseIdentifier:@"animationCell"];
    [self.view addSubview:self.tableView];

    _animationDirection = @"right";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnimationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"animationCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[AnimationCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"animationCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.tableView];
    self.beginPoint = point;
//    设置tableview的滚动属性为false，这么做的原因就是避免在滑动的时候，事件被tableView的滚动给阻断掉
    self.tableView.scrollEnabled = false;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"animationCellAnimation" object:@{@"type":@"begin"}];
}

- (void)tableView:(UITableView *)tableView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.tableView];
    CGFloat x = point.x - self.beginPoint.x;
    NSLog(@"moved = %f",x);
    /*
     *判断滑动的时候，获取当前手指所在的位置距离begin的时候的距离x，这里是以100为一个基准，通过差值来改变圆环的弧度
     *_animationDirection 是判断当前状态是可以向哪个方向滑动，为right的时候，标明圆环弧度为0，为left的时候，表示圆环的弧度为M_PI
     *这里的是以100为一个标准，当x的的值为100的时候，圆弧弧度就不会随着x值的变大再进行改变
     */
    if ([_animationDirection isEqualToString:@"right"]) {
        if (x >= 0 && x <= 100) {
            x = x/100.0;
        }
    }else if ([_animationDirection isEqualToString:@"left"]) {
        if (x<0 && x >=-100) {
            x = x * -1;
            x = 100 - x;
            x = x/100;
        }
    }
//    发送通知，传入当前的差值
    if (x >= 0 && x <= 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"animationCellAnimation" object:@{@"persent":[NSString stringWithFormat:@"%f",x],@"type":@"move"}];
    }
}

- (void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.tableView];
    CGFloat x = point.x - self.beginPoint.x;
    /**
     *这里是在触摸结束的时候，判断结束点距离开始点的差值x，如果_animationDirection是right的时，标明圆弧是从无到有，当x大于50的时候，也就是100的一半，就直接将完成弧度绘画，x=1表示圆弧弧度为M_PI
     *_animationDirection开始为right的时候，X>50 将_animationDirection的值设为left；x<= 50且 x>0 直接将圆弧弧度设为0
     *_animationDirection为left的时候，x<-50 ,将_animationDirection的值设为right，并将圆弧弧度设为0；x>=-50 且x<0 ，这时将圆弧的弧度设为M_PI
     */
    if ([_animationDirection isEqualToString:@"right"]) {
        if (x > 50) {
            _animationDirection = @"left";
            x = 1;
        }else if (x <=50 && x > 0){
            x = 0;
        }
    }else if ([_animationDirection isEqualToString:@"left"]){
        if (x < -50) {
            _animationDirection = @"right";
            x = 0;
        }else if (x >= -50 && x < 0){
            x = 1;
        }
    }
//    发送通知
    if (x >=0 && x <= 1) {
        NSString * str = [NSString stringWithFormat:@"%f",x];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"animationCellAnimation" object:@{@"persent":str,@"type":@"end"}];
    }
//    设置tableview的滚动属性为true
    self.tableView.scrollEnabled = true;
}

@end
