//
//  ViewController.m
//  RoundedCorners
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.layerView1.layer.cornerRadius = 20;
    self.layerView2.layer.cornerRadius = 20;
    
    //add a border to our layers
    self.layerView1.layer.borderWidth = 5;
    self.layerView2.layer.borderWidth = 5;
    
    //add border color
    self.layerView1.layer.borderColor = [UIColor blueColor].CGColor;
    
    
    self.layerView2.layer.masksToBounds = true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
