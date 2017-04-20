//
//  ViewController.m
//  LayerAction
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
    //began a new transaction 开始动作，入栈
    [CATransaction begin];
    
    //set the animation duration 1 second
    [CATransaction setAnimationDuration:2.0];
    
    self.colorLayer.backgroundColor = [UIColor randomColor].CGColor;
    //commit action，出栈
    [CATransaction commit];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 200, 200);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
