//
//  ViewController.m
//  AffineTransform
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/4);
    self.layerView.layer.affineTransform = transform;
     */
    
    //create a new transform,设置一个transform的初始值
    CGAffineTransform transform = CGAffineTransformIdentity;
    //scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    //rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI/6);
    //translate by 200 points
    transform = CGAffineTransformTranslate(transform, 200, 0);
    //apply transform to layer
    self.layerView.layer.affineTransform = transform;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
