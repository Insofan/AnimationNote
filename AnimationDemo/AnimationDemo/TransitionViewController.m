//
//  TransitionViewController.m
//  AnimationDemo
//
//  Created by 海啸 on 2017/4/28.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()
@property (copy, nonatomic  ) NSArray    *animatetionArray;
@property (strong, nonatomic) UIView     *demoView;
@property (strong, nonatomic) UILabel    *demoLabel;
@property (assign, nonatomic) NSInteger index;
@end

@implementation TransitionViewController

- (NSArray *)animatetionArray {
    return [NSArray arrayWithObjects:@"fade",@"moveIn",@"push",@"reveal",@"cube",@"suck",@"oglFlip",@"ripple",@"Curl",@"UnCurl",@"caOpen",@"caClose", nil];
}

- (void)loadView {
    [super loadView];
    [self setupVer];
}

- (void)setupVer {
    //设置12个流水button
    MyFlowLayout *flow = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:4];
    flow.bottomPos.equalTo(self.view.bottomPos);
    flow.wrapContentHeight = true;
    flow.myWidth = [UIScreen screenWidth];
    flow.padding = UIEdgeInsetsMake(10, 50, 10, 50);
    flow.gravity = MyGravity_Horz_Fill;
    flow.subviewSpace = 10;
    
    for (int i = 0 ; i < 12; i++) {
        UIButton *button = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%@", [self.animatetionArray objectAtIndex:i]] fontSize:18 normalColor:[UIColor blackColor] selectedColor:[UIColor blueColor]];
        button.myHeight = 30;
        [flow addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor purpleColor];
    }
    [self.view addSubview:flow];
    flow.backgroundColor = [UIColor clearColor];
}

- (void)click:(UIButton *)button {
    NSLog(@"tag is %ld", button.tag);
    //12个专场动画
    switch (button.tag) {
        case 0:
            [self fadeAnimation];
            break;
        case 1:
            [self moveInAnimation];
            break;
        case 2:
            [self pushAnimation];
            break;
        case 3:
            [self revealAnimation];
            break;
        case 4:
            [self cubeAnimation];
            break;
        case 5:
            [self suckEffectAnimation];
            break;
        case 6:
            [self oglFlipAnimation];
            break;
        case 7:
            [self rippleEffectAnimation];
            break;
        case 8:
            [self pageCurlAnimation];
            break;
        case 9:
            [self pageUnCurlAnimation];
            break;
        case 10:
            [self cameraIrisHollowOpenAnimation];
            break;
        case 11:
            [self cameraIrisHollowCloseAnimation];
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
            make.width.height.mas_equalTo([UIScreen screenWidth]/2);
        }];
        _demoView.backgroundColor = [UIColor randomColor];
        _demoLabel = [UILabel new];
        [_demoView addSubview:_demoLabel];
        [_demoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.width.height.mas_equalTo([UIScreen screenWidth]/4);
        }];
        _demoLabel.text = @"1";
        _demoLabel.textAlignment = NSTextAlignmentCenter;
        _demoLabel.font = [UIFont systemFontOfSize:40];
    }
    return _demoView;
}

//animation
- (void)fadeAnimation {
    [self changeLabel:true];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    //anima.startProgress = 0.3;//设置动画起点
    //anima.endProgress = 0.8;//设置动画终点
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"fadeAnimation"];
}

- (void)moveInAnimation {
    [self changeLabel:true];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;
    anima.subtype = kCATransitionFromRight;
    anima.duration = 1.0;
    [_demoView.layer addAnimation:anima forKey:@"moveInAnimation"];
}

- (void)pushAnimation {
    [self changeLabel:true];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;
    anima.subtype = kCATransitionFromBottom;
    anima.duration = 1;
    [_demoView.layer addAnimation:anima forKey:@"pushAnimation"];
    
}

-(void)revealAnimation{
    [self changeLabel:true];
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}

-(void)cubeAnimation{
    [self changeLabel:true];
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"revealAnimation"];
}


-(void)suckEffectAnimation{
    [self changeLabel:true];
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

-(void)oglFlipAnimation{
    [self changeLabel:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}

-(void)rippleEffectAnimation{
    [self changeLabel:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}

-(void)pageCurlAnimation{
    [self changeLabel:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}

-(void)pageUnCurlAnimation{
    [self changeLabel:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

-(void)cameraIrisHollowOpenAnimation{
    [self changeLabel:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowOpen";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowOpenAnimation"];
}

-(void)cameraIrisHollowCloseAnimation{
    [self changeLabel:YES];
    CATransition *anima = [CATransition animation];
    anima.type = @"cameraIrisHollowClose";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    
    [_demoView.layer addAnimation:anima forKey:@"cameraIrisHollowCloseAnimation"];
}

- (void)changeLabel:(BOOL)isIncresment {
    if (_index > 3) {
        _index = 0;
    }
    if (_index < 0) {
        _index = 3;
    }
    NSArray *colors = [NSArray arrayWithObjects:[UIColor randomColor],[UIColor randomColor],[UIColor randomColor],[UIColor randomColor], nil];
    NSArray *titles = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    _demoView.backgroundColor = [colors objectAtIndex:_index];
    _demoLabel.text = [titles objectAtIndex:_index];
    
    
    if (isIncresment) {
        _index++;
    }else{
        _index--;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self demoView];
}
@end
