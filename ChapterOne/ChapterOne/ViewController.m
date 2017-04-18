//
//  ViewController.m
//  ChapterOne
//
//  Created by 海啸 on 2017/4/18.
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
        _whiteView.backgroundColor = [UIColor whiteColor];
        [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo([UIScreen screenWidth]/2);
            make.center.mas_equalTo(self.view);
        }];
    }
    return _whiteView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self whiteView];
    //1 layer
    
     //建立蓝色图层 注意图层颜色的写法
     CALayer *blueLayer = [CALayer layer];
     blueLayer.frame = CGRectMake(50, 50, 100, 100);
     blueLayer.backgroundColor = [UIColor blueColor].CGColor;
     [self.whiteView.layer addSublayer:blueLayer];
   
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
