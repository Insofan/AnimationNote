//
//  ViewController.m
//  ZPosition
//
//  Created by 海啸 on 2017/4/18.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //在sb中设置的是红色遮住了绿色他们的zPosition默认为0，移动绿色的zPosition改变位置为1,编程绿色遮住红色
    self.greenView.layer.zPosition = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
