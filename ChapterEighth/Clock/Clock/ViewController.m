//
//  ViewController.m
//  Clock
//
//  Created by 海啸 on 2017/4/24.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHand;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    //使用kvc对动画打标签
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置 anchor points
    self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.9);
    //start time
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:true];
    //set initial hand positions
    
}

- (void)tick {
    [self updateHandsAnimated:true];
}

- (void)updateHandsAnimated:(BOOL)animated {
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour /12.0) * M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
}



@end
