//
//  ViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/1.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ViewController.h"
#import "AnimationViewController.h"
#import "StrokeView.h"
#import "CGContextViewController.h"
#import "LayerViewController.h"

static const CGFloat radius = 100;
static const CGFloat lineWidth = 20;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/*注释*/
@property (nonatomic,strong) NSMutableArray *dataAry;
/*注释*/
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController


/*注释*/
- (NSMutableArray *)dataAry
{
    if(!_dataAry){
        _dataAry = [NSMutableArray arrayWithObjects:@"CGContext绘图",@"Layer绘图动画", nil];
    }
    return _dataAry;
}

/*注释*/
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"animationCell"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"animationCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataAry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * title = self.dataAry[indexPath.row];
    if ([title isEqualToString:@"CGContext绘图"]) {
        CGContextViewController * viewController = [[CGContextViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:true];
    }else if ([title isEqualToString:@"Layer绘图动画"]){
        LayerViewController * viewController = [[LayerViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:true];
    }else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
