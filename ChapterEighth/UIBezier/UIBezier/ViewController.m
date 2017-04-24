//
//  ViewController.m
//  UIBezier
//
//  Created by 海啸 on 2017/4/24.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //用 painteCode 画bezier曲线
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.635 green: 0 blue: 0.09 alpha: 1];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(139.5, 161.42)];
    [bezierPath addCurveToPoint: CGPointMake(297.52, 161.42) controlPoint1: CGPointMake(174.07, -16.15) controlPoint2: CGPointMake(297.52, 161.42)];
    [bezierPath addLineToPoint: CGPointMake(396.29, 282.5)];
    [bezierPath addLineToPoint: CGPointMake(539.5, 161.42)];
    [color setStroke];
//    bezierPath.lineWidth = 1;
//    [bezierPath stroke];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0;
    [self.containerView.layer addSublayer:pathLayer];
    
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"Ship"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    //设置自动飞机转头
    animation.rotationMode = kCAAnimationRotateAuto;
    [shipLayer addAnimation:animation forKey:nil];
    
}



@end
