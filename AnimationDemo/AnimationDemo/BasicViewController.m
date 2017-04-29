//
//  BasicViewController.m
//  AnimationDemo
//
//  Created by 海啸 on 2017/4/29.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()
@property (copy, nonatomic  ) NSArray    *animatetionArray;
@property (strong, nonatomic) UIView     *demoView;

@end

@implementation BasicViewController

- (NSArray *)animatetionArray {
    return [NSArray arrayWithObjects:@"position",@"opacity",@"scale",@"rotate",@"background", nil];
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
    
    for (int i = 0 ; i < 5; i++) {
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
            [self positionAnimation];
            break;
        case 1:
            [self opacityAnimation];
            break;
        case 2:
            [self scaleAnimation];
            break;
        case 3:
            [self rotateAnimation];
            break;
        case 4:
            [self backgroundAnimation];
            break;
        default:
            break;
    }
    
}


//位置动画
- (void)positionAnimation {
    //创建position动画
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/2, 0)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen screenWidth]/2, [UIScreen screenHeight]/2)];
    //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    //anima.fillMode = kCAFillModeForwards;
    //anima.removedOnCompletion = false;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_demoView.layer addAnimation:anima forKey:@"positionAnimation"];
    
    //使用UIView Animation 代码块调用
    //    _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
    //    [UIView animateWithDuration:1.0f animations:^{
    //        _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
    //    } completion:^(BOOL finished) {
    //        _demoView.frame = CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50, 50, 50);
    //    }];
    //
    //使用UIView [begin,commit]模式
    //    _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:1.0f];
    //    _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
    //    [UIView commitAnimations];
}

//透明动画
- (void)opacityAnimation {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0];
    anima.toValue = [NSNumber numberWithFloat:0.2];
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"opacityAniamtion"];
}

//缩放动画
- (void)scaleAnimation {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue  = [NSNumber numberWithFloat:1.5];
    anima.duration = 1.5;
    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"];
}

//旋转动画
- (void)rotateAnimation {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima.toValue = [NSNumber numberWithFloat:2 * M_PI];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
    //    //valueWithCATransform3D作用与layer
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];//绕着矢量（x,y,z）旋转
    //    anima.duration = 1.0f;
    //    //anima.repeatCount = MAXFLOAT;
    //    [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    //    //CGAffineTransform作用与View
    //    _demoView.transform = CGAffineTransformMakeRotation(0);
    //    [UIView animateWithDuration:1.0f animations:^{
    //        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    //    } completion:^(BOOL finished) {
    //        
    //    }];
}

- (void)backgroundAnimation {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue =(id) [UIColor blueColor].CGColor;
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"backgroundAnimation"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self demoView];
}

@end
