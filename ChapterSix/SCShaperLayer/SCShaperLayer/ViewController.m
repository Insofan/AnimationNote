//
//  ViewController.m
//  SCShaperLayer
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //通过CGPath来绘制图形
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    //画圆圈,计算园的中心点，如果radius是50所以x向左或者向右50个单位,此时是25
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:true];
    [path moveToPoint:CGPointMake(150, 125)];
    //画一个50长度的垂直直线
    [path addLineToPoint:CGPointMake(150, 175)];
    //画线是用addLine
    [path addLineToPoint:CGPointMake(125, 225)];
    //移动点去一个起点
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    
     [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //可以单独设置每一个圆角
//    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;
    shapeLayer.path = path.CGPath;
    [self.containerView.layer addSublayer:shapeLayer];
    
}


@end
