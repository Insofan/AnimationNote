//
//  ViewController.m
//  Transactions
//
//  Created by 海啸 on 2017/4/20.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"
#import <HXTool.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (strong, nonatomic) CALayer *colorLayer;
@end

@implementation ViewController
- (IBAction)changeColor:(id)sender {
    //began transaction
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_4);
        self.colorLayer.affineTransform = transform;
    }];
    self.colorLayer.backgroundColor = [UIColor randomColor].CGColor;
    [CATransaction commit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 150, 150);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
