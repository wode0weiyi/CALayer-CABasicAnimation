//
//  LayerViewController.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/8.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "LayerViewController.h"
#import "ShowLayerViewController.h"

@interface LayerViewController ()<UITableViewDelegate,UITableViewDataSource>
/*注释*/
@property (nonatomic,strong) NSMutableArray *layers;
/*注释*/
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation LayerViewController

/*注释*/
- (NSMutableArray *)layers
{
    if(!_layers){
        _layers = [NSMutableArray arrayWithObjects:@"CALayer",@"CASheperLayer",@"gradientLayer", nil];
    }
    return _layers;
}

/*注释*/
- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.layers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.textLabel.text = self.layers[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * str = self.layers[indexPath.row];
    ShowLayerViewController * viewController = [[ShowLayerViewController alloc] init];
    if ([str isEqualToString:@"CALayer"]) {
        viewController.layerType = CALayerLayer;
    }else if ([str isEqualToString:@"CASheperLayer"]){
        viewController.layerType = CALayerShapeLayer;
    }else if([str isEqualToString:@"gradientLayer"]){
        viewController.layerType = CALayerGradientLayer;
    }
    [self.navigationController pushViewController:viewController animated:true];
}

@end
