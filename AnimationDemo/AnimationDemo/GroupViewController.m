//
//  GroupViewController.m
//  AnimationDemo
//
//  Created by 海啸 on 2017/4/29.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()
@property (copy, nonatomic  ) NSArray    *animatetionArray;
@property (strong, nonatomic) UIView     *demoView;
@end

@implementation GroupViewController
- (NSArray *)animatetionArray {
    return [NSArray arrayWithObjects:@"同时",@"连续", nil];
}

- (void)loadView {
    [super loadView];
    [self setupVer];
}

- (void)setupVer {
    //设置12个流水button
    MyFlowLayout *flow = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:2];
    flow.bottomPos.equalTo(self.view.bottomPos);
    flow.wrapContentHeight = true;
    flow.myWidth = [UIScreen screenWidth];
    flow.padding = UIEdgeInsetsMake(10, 50, 30, 50);
    flow.gravity = MyGravity_Horz_Fill;
    flow.subviewSpace = 10;
    
    for (int i = 0 ; i < self.animatetionArray.count; i++) {
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

- (void)changeView:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self durationAnimation];
            break;
        case 1:
            [self runningAnimation];
            break;
        default:
            break;
    }
    
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

- (void)durationAnimation {
    //keyFrameAnimation 里面的keyFrameAnimation
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, [UIScreen screenHeight]/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/3, [UIScreen screenHeight]/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/3, [UIScreen screenHeight]/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]*2/3, [UIScreen screenHeight]/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]*2/3, [UIScreen screenHeight]/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth], [UIScreen screenHeight]/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
   
    //Basic 里面的rotate
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima2.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    //Basic 里面scale
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima3.toValue  = [NSNumber numberWithFloat:1.5];
    
    //定义组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:anima1, anima2, anima3, nil];
    //先不设置动画时间最后group一起设置duration
    group.duration = 4.0f;
    
    //keyPath必须要设置定值而forKey而不必要
    [_demoView.layer addAnimation:group forKey:@"groupAnimation"];
    
    //-------------如下，使用三个animation不分装成group，只是把他们添加到layer，也有组动画的效果。-------------
    //    //位移动画
    //    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    //    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    //    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    //    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    //    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    //    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    //    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    //    anima1.duration = 4.0f;
    //    [_demoView.layer addAnimation:anima1 forKey:@"aa"];
    //
    //    //缩放动画
    //    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    //    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    //    anima2.duration = 4.0f;
    //    [_demoView.layer addAnimation:anima2 forKey:@"bb"];
    //
    //    //旋转动画
    //    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    //    anima3.duration = 4.0f;
    //    [_demoView.layer addAnimation:anima3 forKey:@"cc"];
    
    
}

//按顺序执行的动画
- (void)runningAnimation {
    //先设置meadiaTime
    CFTimeInterval currentTimer = CACurrentMediaTime();
    //位移动画，keyFrame的第一段动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, [UIScreen screenHeight]/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/3, [UIScreen screenHeight]/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/3, [UIScreen screenHeight]/2+50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2, nil];
    anima1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
//    anima1.delegate = self;//设置代理，可以检测动画的开始和结束
    anima1.beginTime = currentTimer;
    anima1.duration = 2.0;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = false;
    [_demoView.layer addAnimation:anima1 forKey:@"a"];
    
    //Basic 里面的rotate
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima2.toValue = [NSNumber numberWithFloat:2 * M_PI];
    anima2.beginTime = currentTimer + 2;
    anima2.duration = 2;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = false;
    [_demoView.layer addAnimation:anima2 forKey:@"b"];
    
    //位移动画，keyFrame的第二段动画
    CAKeyframeAnimation *anima3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //注意要重新添加value2,否则会跳过2到3的过程
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]*2/3, [UIScreen screenHeight]/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]*2/3, [UIScreen screenHeight]/2-50)];
    //注意要重新添加value2,否则会跳过2到3的过程
    anima3.values = [NSArray arrayWithObjects:value2, value3,value4, nil];
    anima3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    //    anima1.delegate = self;//设置代理，可以检测动画的开始和结束
    anima3.beginTime = currentTimer+4;
    anima3.duration = 2.0;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = false;
    [_demoView.layer addAnimation:anima3 forKey:@"c"];
    
    //添加缩放动画
    CABasicAnimation *anima4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima4.toValue  = [NSNumber numberWithFloat:1.5];
    anima4.beginTime = currentTimer +6;
    anima4.fillMode = kCAFillModeForwards;
    anima4.removedOnCompletion = false;
    anima4.duration = 2.0;
    [_demoView.layer addAnimation:anima4 forKey:@"d"];
   
    //位移动画，keyFrame的第三段动画
    CAKeyframeAnimation *anima5 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth], [UIScreen screenHeight]/2-50)];
    anima5.values = [NSArray arrayWithObjects:value4, value5, nil];
    anima5.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    //    anima1.delegate = self;//设置代理，可以检测动画的开始和结束
    anima5.beginTime = currentTimer+8;
    anima5.duration = 2.0;
    anima5.fillMode = kCAFillModeForwards;
    anima5.removedOnCompletion = false;
    [_demoView.layer addAnimation:anima5 forKey:@"e"];
    
    
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
