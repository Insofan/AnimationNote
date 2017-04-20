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
    /*
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
    */
    
    UIColor* fillColor = [UIColor clearColor];
    
    //画一个苹果的genius图形
    //// genius Drawing
    UIBezierPath* geniusPath = [UIBezierPath bezierPath];
    [geniusPath moveToPoint: CGPointMake(4.06, 194.66)];
    [geniusPath addCurveToPoint: CGPointMake(82.92, 199.43) controlPoint1: CGPointMake(13.54, 209.11) controlPoint2: CGPointMake(44.17, 209.74)];
    [geniusPath addCurveToPoint: CGPointMake(130.34, 260) controlPoint1: CGPointMake(92.86, 235.83) controlPoint2: CGPointMake(110.38, 260)];
    [geniusPath addCurveToPoint: CGPointMake(177.67, 199.76) controlPoint1: CGPointMake(150.24, 260) controlPoint2: CGPointMake(167.72, 235.98)];
    [geniusPath addCurveToPoint: CGPointMake(198.91, 204.11) controlPoint1: CGPointMake(185.07, 201.62) controlPoint2: CGPointMake(192.18, 203.07)];
    [geniusPath addCurveToPoint: CGPointMake(212.23, 216.5) controlPoint1: CGPointMake(198.89, 211.19) controlPoint2: CGPointMake(204.86, 216.5)];
    [geniusPath addCurveToPoint: CGPointMake(225.48, 205.95) controlPoint1: CGPointMake(219.09, 216.5) controlPoint2: CGPointMake(224.74, 211.89)];
    [geniusPath addCurveToPoint: CGPointMake(257.03, 193.59) controlPoint1: CGPointMake(240.74, 205.39) controlPoint2: CGPointMake(251.93, 201.36)];
    [geniusPath addCurveToPoint: CGPointMake(221.82, 128.63) controlPoint1: CGPointMake(266.74, 178.78) controlPoint2: CGPointMake(252.03, 153.94)];
    [geniusPath addCurveToPoint: CGPointMake(256.49, 64.36) controlPoint1: CGPointMake(251.62, 103.58) controlPoint2: CGPointMake(266.11, 79.02)];
    [geniusPath addCurveToPoint: CGPointMake(177.14, 58.35) controlPoint1: CGPointMake(246.97, 49.84) controlPoint2: CGPointMake(216.12, 48.48)];
    [geniusPath addCurveToPoint: CGPointMake(172.73, 44.88) controlPoint1: CGPointMake(175.8, 53.64) controlPoint2: CGPointMake(174.32, 49.14)];
    [geniusPath addCurveToPoint: CGPointMake(177.78, 35.59) controlPoint1: CGPointMake(175.81, 42.71) controlPoint2: CGPointMake(177.78, 39.36)];
    [geniusPath addCurveToPoint: CGPointMake(164.45, 23.73) controlPoint1: CGPointMake(177.78, 29.04) controlPoint2: CGPointMake(171.81, 23.73)];
    [geniusPath addCurveToPoint: CGPointMake(162.71, 23.83) controlPoint1: CGPointMake(163.86, 23.73) controlPoint2: CGPointMake(163.28, 23.76)];
    [geniusPath addCurveToPoint: CGPointMake(130.34, 0) controlPoint1: CGPointMake(153.57, 8.82) controlPoint2: CGPointMake(142.4, 0)];
    [geniusPath addCurveToPoint: CGPointMake(83.48, 58.55) controlPoint1: CGPointMake(110.75, 0) controlPoint2: CGPointMake(93.51, 23.28)];
    [geniusPath addCurveToPoint: CGPointMake(2.97, 64.44) controlPoint1: CGPointMake(43.95, 48.45) controlPoint2: CGPointMake(12.6, 49.75)];
    [geniusPath addCurveToPoint: CGPointMake(38.23, 129.43) controlPoint1: CGPointMake(-6.75, 79.25) controlPoint2: CGPointMake(7.99, 104.11)];
    [geniusPath addCurveToPoint: CGPointMake(26.8, 140.06) controlPoint1: CGPointMake(34.12, 132.99) controlPoint2: CGPointMake(30.3, 136.54)];
    [geniusPath addCurveToPoint: CGPointMake(20, 138.4) controlPoint1: CGPointMake(24.81, 139.01) controlPoint2: CGPointMake(22.48, 138.4)];
    [geniusPath addCurveToPoint: CGPointMake(6.67, 150.27) controlPoint1: CGPointMake(12.64, 138.4) controlPoint2: CGPointMake(6.67, 143.71)];
    [geniusPath addCurveToPoint: CGPointMake(10.9, 158.94) controlPoint1: CGPointMake(6.67, 153.69) controlPoint2: CGPointMake(8.3, 156.77)];
    [geniusPath addCurveToPoint: CGPointMake(4.06, 194.66) controlPoint1: CGPointMake(1.2, 173.2) controlPoint2: CGPointMake(-1.71, 185.85)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(178.5, 196.64)];
    [geniusPath addCurveToPoint: CGPointMake(185.42, 154.63) controlPoint1: CGPointMake(181.79, 183.89) controlPoint2: CGPointMake(184.17, 169.72)];
    [geniusPath addCurveToPoint: CGPointMake(217.59, 132.1) controlPoint1: CGPointMake(197.35, 147.29) controlPoint2: CGPointMake(208.15, 139.69)];
    [geniusPath addCurveToPoint: CGPointMake(254.89, 191.54) controlPoint1: CGPointMake(244.96, 153.7) controlPoint2: CGPointMake(259.43, 174.26)];
    [geniusPath addCurveToPoint: CGPointMake(225.45, 203.08) controlPoint1: CGPointMake(251.31, 198.92) controlPoint2: CGPointMake(240.62, 202.72)];
    [geniusPath addCurveToPoint: CGPointMake(212.23, 192.78) controlPoint1: CGPointMake(224.59, 197.27) controlPoint2: CGPointMake(219, 192.78)];
    [geniusPath addCurveToPoint: CGPointMake(199.51, 201.06) controlPoint1: CGPointMake(206.26, 192.78) controlPoint2: CGPointMake(201.22, 196.26)];
    [geniusPath addCurveToPoint: CGPointMake(178.5, 196.64) controlPoint1: CGPointMake(192.86, 199.99) controlPoint2: CGPointMake(185.82, 198.52)];
    [geniusPath addLineToPoint: CGPointMake(178.5, 196.64)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(14.62, 161.12)];
    [geniusPath addCurveToPoint: CGPointMake(7.34, 193.52) controlPoint1: CGPointMake(5.39, 174.35) controlPoint2: CGPointMake(2.56, 185.8)];
    [geniusPath addCurveToPoint: CGPointMake(81.94, 195.72) controlPoint1: CGPointMake(16.72, 204.45) controlPoint2: CGPointMake(45.77, 204.94)];
    [geniusPath addLineToPoint: CGPointMake(81.94, 195.72)];
    [geniusPath addCurveToPoint: CGPointMake(75.37, 155.82) controlPoint1: CGPointMake(78.86, 183.55) controlPoint2: CGPointMake(76.61, 170.11)];
    [geniusPath addCurveToPoint: CGPointMake(41.83, 132.39) controlPoint1: CGPointMake(62.9, 148.19) controlPoint2: CGPointMake(51.63, 140.29)];
    [geniusPath addCurveToPoint: CGPointMake(30.39, 142.83) controlPoint1: CGPointMake(37.7, 135.9) controlPoint2: CGPointMake(33.88, 139.39)];
    [geniusPath addCurveToPoint: CGPointMake(33.33, 150.27) controlPoint1: CGPointMake(32.23, 144.86) controlPoint2: CGPointMake(33.33, 147.45)];
    [geniusPath addCurveToPoint: CGPointMake(20, 162.13) controlPoint1: CGPointMake(33.33, 156.82) controlPoint2: CGPointMake(27.36, 162.13)];
    [geniusPath addCurveToPoint: CGPointMake(14.62, 161.12) controlPoint1: CGPointMake(18.09, 162.13) controlPoint2: CGPointMake(16.27, 161.77)];
    [geniusPath addLineToPoint: CGPointMake(14.62, 161.12)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(253.78, 66.48)];
    [geniusPath addCurveToPoint: CGPointMake(218.1, 125.58) controlPoint1: CGPointMake(261, 78.72) controlPoint2: CGPointMake(246.77, 101.44)];
    [geniusPath addCurveToPoint: CGPointMake(185.17, 102.53) controlPoint1: CGPointMake(208.46, 117.81) controlPoint2: CGPointMake(197.4, 110.04)];
    [geniusPath addCurveToPoint: CGPointMake(178.2, 62.21) controlPoint1: CGPointMake(183.82, 88.05) controlPoint2: CGPointMake(181.44, 74.46)];
    [geniusPath addCurveToPoint: CGPointMake(253.78, 66.48) controlPoint1: CGPointMake(213.53, 52.94) controlPoint2: CGPointMake(242.39, 53.24)];
    [geniusPath addLineToPoint: CGPointMake(253.78, 66.48)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(41.77, 126.43)];
    [geniusPath addCurveToPoint: CGPointMake(75.54, 102.26) controlPoint1: CGPointMake(51.6, 118.25) controlPoint2: CGPointMake(62.95, 110.08)];
    [geniusPath addCurveToPoint: CGPointMake(82.3, 62.88) controlPoint1: CGPointMake(76.86, 88.14) controlPoint2: CGPointMake(79.18, 74.88)];
    [geniusPath addCurveToPoint: CGPointMake(7.22, 66.24) controlPoint1: CGPointMake(44.72, 52.96) controlPoint2: CGPointMake(14.88, 53.87)];
    [geniusPath addCurveToPoint: CGPointMake(41.77, 126.43) controlPoint1: CGPointMake(-0.61, 78.87) controlPoint2: CGPointMake(11.77, 101.53)];
    [geniusPath addLineToPoint: CGPointMake(41.77, 126.43)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(185.76, 109.99)];
    [geniusPath addCurveToPoint: CGPointMake(213.77, 129.14) controlPoint1: CGPointMake(196.07, 116.42) controlPoint2: CGPointMake(205.46, 122.82)];
    [geniusPath addCurveToPoint: CGPointMake(185.81, 149.24) controlPoint1: CGPointMake(205.47, 135.83) controlPoint2: CGPointMake(196.11, 142.59)];
    [geniusPath addCurveToPoint: CGPointMake(186.42, 130) controlPoint1: CGPointMake(186.21, 142.96) controlPoint2: CGPointMake(186.42, 136.54)];
    [geniusPath addCurveToPoint: CGPointMake(185.76, 109.99) controlPoint1: CGPointMake(186.42, 123.2) controlPoint2: CGPointMake(186.2, 116.52)];
    [geniusPath addLineToPoint: CGPointMake(185.76, 109.99)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(74.93, 150.14)];
    [geniusPath addCurveToPoint: CGPointMake(45.42, 129.4) controlPoint1: CGPointMake(63.83, 143.19) controlPoint2: CGPointMake(53.98, 136.22)];
    [geniusPath addCurveToPoint: CGPointMake(75.05, 108.17) controlPoint1: CGPointMake(54.09, 122.32) controlPoint2: CGPointMake(64.01, 115.17)];
    [geniusPath addCurveToPoint: CGPointMake(74.26, 130) controlPoint1: CGPointMake(74.53, 115.27) controlPoint2: CGPointMake(74.26, 122.56)];
    [geniusPath addCurveToPoint: CGPointMake(74.93, 150.14) controlPoint1: CGPointMake(74.26, 136.85) controlPoint2: CGPointMake(74.49, 143.58)];
    [geniusPath addLineToPoint: CGPointMake(74.93, 150.14)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(172.4, 195)];
    [geniusPath addCurveToPoint: CGPointMake(134, 181.33) controlPoint1: CGPointMake(160.1, 191.53) controlPoint2: CGPointMake(147.13, 186.96)];
    [geniusPath addCurveToPoint: CGPointMake(157.6, 170.19) controlPoint1: CGPointMake(141.8, 177.93) controlPoint2: CGPointMake(149.7, 174.21)];
    [geniusPath addCurveToPoint: CGPointMake(178.56, 158.74) controlPoint1: CGPointMake(164.88, 166.49) controlPoint2: CGPointMake(171.88, 162.66)];
    [geniusPath addCurveToPoint: CGPointMake(172.4, 195) controlPoint1: CGPointMake(177.27, 171.71) controlPoint2: CGPointMake(175.16, 183.91)];
    [geniusPath addLineToPoint: CGPointMake(172.4, 195)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(88.11, 64.49)];
    [geniusPath addCurveToPoint: CGPointMake(123.57, 77.07) controlPoint1: CGPointMake(99.44, 67.74) controlPoint2: CGPointMake(111.38, 71.95)];
    [geniusPath addCurveToPoint: CGPointMake(102.95, 86.84) controlPoint1: CGPointMake(116.74, 80.08) controlPoint2: CGPointMake(109.85, 83.34)];
    [geniusPath addCurveToPoint: CGPointMake(82.31, 98.16) controlPoint1: CGPointMake(95.79, 90.48) controlPoint2: CGPointMake(88.9, 94.27)];
    [geniusPath addCurveToPoint: CGPointMake(88.11, 64.49) controlPoint1: CGPointMake(83.59, 86.16) controlPoint2: CGPointMake(85.57, 74.84)];
    [geniusPath addLineToPoint: CGPointMake(88.11, 64.49)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(171.08, 60.07)];
    [geniusPath addCurveToPoint: CGPointMake(129.66, 74.53) controlPoint1: CGPointMake(157.93, 63.7) controlPoint2: CGPointMake(143.97, 68.54)];
    [geniusPath addCurveToPoint: CGPointMake(88.93, 60.29) controlPoint1: CGPointMake(115.6, 68.66) controlPoint2: CGPointMake(101.88, 63.89)];
    [geniusPath addCurveToPoint: CGPointMake(130.03, 2.94) controlPoint1: CGPointMake(98.18, 25.75) controlPoint2: CGPointMake(113.8, 2.94)];
    [geniusPath addCurveToPoint: CGPointMake(157.52, 25.49) controlPoint1: CGPointMake(139.84, 2.94) controlPoint2: CGPointMake(149.43, 11.27)];
    [geniusPath addCurveToPoint: CGPointMake(150.81, 35.79) controlPoint1: CGPointMake(153.51, 27.54) controlPoint2: CGPointMake(150.81, 31.38)];
    [geniusPath addCurveToPoint: CGPointMake(164.14, 47.66) controlPoint1: CGPointMake(150.81, 42.34) controlPoint2: CGPointMake(156.78, 47.66)];
    [geniusPath addCurveToPoint: CGPointMake(167.19, 47.34) controlPoint1: CGPointMake(165.19, 47.66) controlPoint2: CGPointMake(166.21, 47.55)];
    [geniusPath addCurveToPoint: CGPointMake(171.08, 60.07) controlPoint1: CGPointMake(168.58, 51.38) controlPoint2: CGPointMake(169.89, 55.63)];
    [geniusPath addLineToPoint: CGPointMake(171.08, 60.07)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(172.41, 63.8)];
    [geniusPath addCurveToPoint: CGPointMake(178.4, 98.47) controlPoint1: CGPointMake(175.05, 74.43) controlPoint2: CGPointMake(177.1, 86.09)];
    [geniusPath addCurveToPoint: CGPointMake(157.5, 87.07) controlPoint1: CGPointMake(171.74, 94.57) controlPoint2: CGPointMake(164.76, 90.76)];
    [geniusPath addCurveToPoint: CGPointMake(135.67, 76.76) controlPoint1: CGPointMake(150.2, 83.35) controlPoint2: CGPointMake(142.9, 79.92)];
    [geniusPath addCurveToPoint: CGPointMake(172.41, 63.8) controlPoint1: CGPointMake(154.01, 69.04) controlPoint2: CGPointMake(160.66, 67.16)];
    [geniusPath addLineToPoint: CGPointMake(172.41, 63.8)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(153.35, 91.79)];
    [geniusPath addCurveToPoint: CGPointMake(178.74, 106.21) controlPoint1: CGPointMake(162.27, 96.59) controlPoint2: CGPointMake(170.76, 101.4)];
    [geniusPath addCurveToPoint: CGPointMake(179.66, 129.7) controlPoint1: CGPointMake(179.34, 113.82) controlPoint2: CGPointMake(179.66, 121.67)];
    [geniusPath addCurveToPoint: CGPointMake(178.69, 153.82) controlPoint1: CGPointMake(179.66, 137.94) controlPoint2: CGPointMake(179.33, 146.01)];
    [geniusPath addCurveToPoint: CGPointMake(157.8, 165.85) controlPoint1: CGPointMake(172.06, 157.91) controlPoint2: CGPointMake(165.08, 161.93)];
    [geniusPath addCurveToPoint: CGPointMake(129.17, 179.67) controlPoint1: CGPointMake(148.26, 170.99) controlPoint2: CGPointMake(138.66, 175.6)];
    [geniusPath addCurveToPoint: CGPointMake(107.08, 168.82) controlPoint1: CGPointMake(121.81, 176.39) controlPoint2: CGPointMake(114.42, 172.77)];
    [geniusPath addCurveToPoint: CGPointMake(81.37, 154.6) controlPoint1: CGPointMake(97.93, 164.14) controlPoint2: CGPointMake(89.36, 159.38)];
    [geniusPath addCurveToPoint: CGPointMake(80.34, 129.7) controlPoint1: CGPointMake(80.7, 146.54) controlPoint2: CGPointMake(80.34, 138.22)];
    [geniusPath addCurveToPoint: CGPointMake(81.41, 104.32) controlPoint1: CGPointMake(80.34, 121.01) controlPoint2: CGPointMake(80.71, 112.52)];
    [geniusPath addCurveToPoint: CGPointMake(98.19, 94.76) controlPoint1: CGPointMake(86.77, 101.09) controlPoint2: CGPointMake(92.37, 97.89)];
    [geniusPath addCurveToPoint: CGPointMake(128.88, 79.82) controlPoint1: CGPointMake(108.4, 89.26) controlPoint2: CGPointMake(118.7, 84.26)];
    [geniusPath addCurveToPoint: CGPointMake(153.35, 91.79) controlPoint1: CGPointMake(136.99, 83.4) controlPoint2: CGPointMake(145.19, 87.4)];
    [geniusPath addLineToPoint: CGPointMake(153.35, 91.79)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(171.3, 197.71)];
    [geniusPath addCurveToPoint: CGPointMake(130.06, 255.59) controlPoint1: CGPointMake(162.07, 232.54) controlPoint2: CGPointMake(146.37, 255.59)];
    [geniusPath addCurveToPoint: CGPointMake(88.7, 197.29) controlPoint1: CGPointMake(113.68, 255.59) controlPoint2: CGPointMake(97.92, 232.36)];
    [geniusPath addCurveToPoint: CGPointMake(128.96, 182.91) controlPoint1: CGPointMake(101.49, 193.59) controlPoint2: CGPointMake(115.06, 188.77)];
    [geniusPath addCurveToPoint: CGPointMake(171.3, 197.71) controlPoint1: CGPointMake(143.59, 189.06) controlPoint2: CGPointMake(157.87, 194.02)];
    [geniusPath addLineToPoint: CGPointMake(171.3, 197.71)];
    [geniusPath closePath];
    [geniusPath moveToPoint: CGPointMake(87.77, 193.9)];
    [geniusPath addCurveToPoint: CGPointMake(80.91, 158.45) controlPoint1: CGPointMake(85.2, 183.4) controlPoint2: CGPointMake(82.17, 170.63)];
    [geniusPath addCurveToPoint: CGPointMake(101.16, 169.49) controlPoint1: CGPointMake(87.38, 162.23) controlPoint2: CGPointMake(94.14, 165.92)];
    [geniusPath addCurveToPoint: CGPointMake(124.2, 180.68) controlPoint1: CGPointMake(108.58, 173.26) controlPoint2: CGPointMake(116.87, 177.49)];
    [geniusPath addCurveToPoint: CGPointMake(87.77, 193.9) controlPoint1: CGPointMake(125.82, 180.01) controlPoint2: CGPointMake(96.05, 192.43)];
    [geniusPath addLineToPoint: CGPointMake(87.77, 193.9)];
    [geniusPath closePath];
    geniusPath.usesEvenOddFillRule = YES;
    [fillColor setFill];
    [geniusPath fill];;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 1;
    shapeLayer.path = geniusPath.CGPath;
    [self.containerView.layer addSublayer:shapeLayer];
}


@end
