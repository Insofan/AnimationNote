//
//  ViewController.m
//  Clock
//
//  Created by 海啸 on 2017/4/18.
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
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour /12.0) * M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
    //rotate hands
    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
