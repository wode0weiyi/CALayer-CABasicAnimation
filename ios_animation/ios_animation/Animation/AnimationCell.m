//
//  AnimationCell.m
//  ios_animation
//
//  Created by 胡志辉 on 2018/8/1.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "AnimationCell.h"

#define kLayerReduis 20
#define kLineWidth 2
#define kLength ((kLayerReduis * 2) + kLineWidth)

@implementation AnimationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*标题图*/
- (UIImageView *)headerImage
{
    if(!_headerImage){
        _headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
        _headerImage.layer.cornerRadius = 20;
        _headerImage.frame = CGRectMake(10 + kLineWidth, 10 + kLineWidth, kLength - 2*kLineWidth, kLength - 2*kLineWidth);
        _headerImage.layer.masksToBounds = true;
    }
    return _headerImage;
}

/**/
- (CAGradientLayer *)gradientLayer
{
    if(!_gradientLayer){
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = CGRectMake(10, 10, kLength, kLength/2.0);
        _gradientLayer.backgroundColor = [UIColor redColor].CGColor;
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 1);
        [self.contentView.layer addSublayer:_gradientLayer];
    }
    return _gradientLayer;
}

- (CAGradientLayer *)gradientLayer2{
    if(!_gradientLayer2){
        _gradientLayer2 = [CAGradientLayer layer];
        _gradientLayer2.frame = CGRectMake(10, 10, kLength, kLength);
        _gradientLayer2.backgroundColor = [UIColor lightGrayColor].CGColor;
        _gradientLayer2.startPoint = CGPointMake(0, 0);
        _gradientLayer2.endPoint = CGPointMake(0, 1);
        [self.contentView.layer addSublayer:_gradientLayer2];
    }
    return _gradientLayer2;
}

/*注释*/
- (CAShapeLayer *)shapeLayer
{
    if(!_shapeLayer){
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake(10, 10, kLength, kLength);
        //    设置蒙版内容
        //shapeLayer的描绘内容为蒙版内容，所以要设置描线颜色，随便什么颜色都可以
        _shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
//        设置填充色为透明
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = kLineWidth;
        [self.contentView.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

/*注释*/
- (CAShapeLayer *)shapeLayer2
{
    if(!_shapeLayer2){
        _shapeLayer2 = [CAShapeLayer layer];
        _shapeLayer2.frame = CGRectMake(10, 10, kLength, kLength/2);
        //    设置蒙版内容
        //shapeLayer的描绘内容为蒙版内容，所以要设置描线颜色，随便什么颜色都可以
        _shapeLayer2.strokeColor = [UIColor lightGrayColor].CGColor;
        //        设置填充色为透明
        _shapeLayer2.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer2.lineWidth = kLineWidth;
        [self.contentView.layer addSublayer:_shapeLayer2];
    }
    return _shapeLayer2;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headerImage];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self gradientLayer2];
//        [self gradientLayer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animation:) name:@"animationCellAnimation" object:nil];
    }
    return self;
}

- (void)animation:(NSNotification *)info{
    NSLog(@"info = %@",info);
    NSString * persentStr = info.object[@"persent"];
    if (persentStr) {
        CGFloat persent = [persentStr floatValue];
        [self headerImageAnimation:persent];
    }
}

-(void)headerImageAnimation:(CGFloat)persent{
    UIBezierPath * path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kLength/2.0, kLength/2.0) radius:kLayerReduis startAngle:M_PI endAngle:(1+persent) * M_PI clockwise:1];
    UIBezierPath * path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kLength/2.0, kLength/2.0) radius:kLayerReduis startAngle:M_PI endAngle:(1-persent) * M_PI clockwise:0];
    self.shapeLayer.path = path1.CGPath;
    self.shapeLayer2.path = path2.CGPath;
//    self.gradientLayer2.mask = self.shapeLayer2;
//    self.gradientLayer.mask = self.shapeLayer;
    if (persent >= 0 && persent < 0.5) {
        self.headerImage.alpha = 1-persent * 1.5;
    }else{
        self.headerImage.alpha = persent;
    }
    
}

//开启
- (void)refreshButtonStartAnimation{
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3;
    rotationAnimation.cumulative = true;
    rotationAnimation.repeatCount = ULLONG_MAX;
    [self.headerImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
