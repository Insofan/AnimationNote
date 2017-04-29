//
//  KeyFrameViewController.m
//  AnimationDemo
//
//  Created by 海啸 on 2017/4/29.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController ()
@property (copy, nonatomic  ) NSArray    *animatetionArray;
@property (strong, nonatomic) UIView     *demoView;

@end

@implementation KeyFrameViewController

- (NSArray *)animatetionArray {
    return [NSArray arrayWithObjects:@"keyFrame",@"path",@"shake", nil];
}

- (void)loadView {
    [super loadView];
    [self setupVer];
}

- (void)setupVer {
    //设置12个流水button
    MyFlowLayout *flow = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:3];
    flow.bottomPos.equalTo(self.view.bottomPos);
    flow.wrapContentHeight = true;
    flow.myWidth = [UIScreen screenWidth];
    flow.padding = UIEdgeInsetsMake(10, 50, 30, 50);
    flow.gravity = MyGravity_Horz_Fill;
    flow.subviewSpace = 10;
    
    for (int i = 0 ; i < 3; i++) {
        UIButton *button = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%@", [self.animatetionArray objectAtIndex:i]] fontSize:18 normalColor:[UIColor blackColor] selectedColor:[UIColor blueColor]];
        button.myHeight = 30;
        [flow addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor purpleColor];
    }
    [self.view addSubview:flow];
    flow.backgroundColor = [UIColor clearColor];
}

- (UIView *)demoView {
    if (!_demoView) {
        _demoView = [UIView new];
        [self.view addSubview:_demoView];
        [_demoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.width.height.mas_equalTo([UIScreen screenWidth]/4);
        }];
        _demoView.backgroundColor = [UIColor randomColor];
    }
    return _demoView;
}

- (void)changeView:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self keyFrameAnimation];
            break;
        case 1:
            [self pathAnimation];
            break;
        case 2:
            [self shakeAnimation];
            break;
        default:
            break;
    }
    
}

- (void)keyFrameAnimation {
    //这一段是yixiang 的代码
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, [UIScreen screenHeight]/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/3, [UIScreen screenHeight]/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/3, [UIScreen screenHeight]/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]*2/3, [UIScreen screenHeight]/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]*2/3, [UIScreen screenHeight]/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth], [UIScreen screenHeight]/2-50)];
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima.duration = 2.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    anima.delegate = self;//设置代理，可以检测动画的开始和结束
    [_demoView.layer addAnimation:anima forKey:@"keyFrameAnimation"];
}

- (void)pathAnimation {
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
   //画个火箭
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(139.5, 161.42)];
    [bezierPath addCurveToPoint: CGPointMake(297.52, 161.42) controlPoint1: CGPointMake(174.07, -16.15) controlPoint2: CGPointMake(297.52, 161.42)];
    [bezierPath addLineToPoint: CGPointMake(396.29, 282.5)];
    [bezierPath addLineToPoint: CGPointMake(539.5, 161.42)];
    
    anima.path = bezierPath.CGPath;
    anima.duration = 2.0f;
    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];
}

//抖动动画
- (void)shakeAnimation {
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*10];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*10];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*10];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = 10;
    
    [_demoView.layer addAnimation:anima forKey:@"shakeAnimation"];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self demoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
