//
//  ViewController.m
//  GroupOpacity
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <HXTool.h>

@interface ViewController ()
@property (strong, nonatomic) UIView *whiteView;
@end

@implementation ViewController

- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [UIView new];
        [self.view addSubview:_whiteView];
        _whiteView.backgroundColor = [UIColor redColor];
        [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _whiteView;
}

- (UIButton *)customButton {
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self whiteView];
    
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(150, 150);
    [self.whiteView addSubview:button1];
    
    //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(350, 150);
    //alpha 默认为1，改变透明为0.5
    button2.alpha = 0.5;
    [self.whiteView addSubview:button2];
    
    //设置组透明效果,应用透明图层和子图层都被整合成一个整体的图片,设置shouldRastersize，必须要设置rasterzationScale
    button2.layer.shouldRasterize = true;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    // Do any additional setup after loading the view, typically from a nib.
}

@end
