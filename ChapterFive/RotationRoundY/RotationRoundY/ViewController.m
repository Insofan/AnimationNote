//
//  ViewController.m
//  RotationRoundY
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (weak, nonatomic) IBOutlet UIView *innerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*z轴旋转
     //旋转45度，按照z轴，提高随意一个数即可
     CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
     self.outerView.layer.transform = outer;
     //rotate inner layer -45 degrees
     //旋转-45度，按照z轴，提高随意一个数即可
     CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 50);
     self.innerView.layer.transform = inner;
     */
    //旋转y轴
    
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1/500.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.outerView.layer.transform = outer;
    
    CATransform3D inner = CATransform3DIdentity;
    //m34一定时-1/500.0
    inner.m34 = -1/500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.innerView.layer.transform =inner;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
