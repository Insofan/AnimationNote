//
//  ViewController.m
//  Clock
//
//  Created by 海啸 on 2017/4/18.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHand;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(thick) userInfo:nil repeats:true];
    // Do any additional setup after loading the view, typically from a nib.
    //三个图片设置的中心原本是和时钟的中心重合的，设置0.5 0.9 后图层向左上移动，
    self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
}

- (void)thick {
    //convert time to hours, minutes and seconds
    [self updateHandsAnimated:true];
   
    
}

- (void)updateHandsAnimated:(BOOL)animated {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour /12.0) * M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
    [self setAngle:hoursAngle forHand:self.hourHand animated:animated];
    [self setAngle:minsAngle forHand:self.minuteHand animated:animated];
    [self setAngle:secsAngle forHand:self.secondHand animated:animated];
}

- (void)setAngle:(CGFloat )angle forHand:(UIView *)handView animated:(BOOL )animated {
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateHandsAnimated:false];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        [animation setValue:handView forKey:@"handView"];
        [handView.layer addAnimation:animation forKey:nil];
    }else {
        handView.layer.transform = transform;
    }
}


- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}

@end
