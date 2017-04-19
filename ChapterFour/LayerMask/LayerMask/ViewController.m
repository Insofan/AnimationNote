//
//  ViewController.m
//  LayerMask
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
   
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"Cone"].CGImage;
    
    //apply mask to image layer
    self.imageView.layer.mask = maskLayer;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
