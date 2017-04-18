//
//  ViewController.m
//  ChapterTwo
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

    
    //contents相关
    UIImage *image = [UIImage imageNamed:@"1"];
    //注意(__bridge id)image.CGImage
    self.whiteView.layer.contents = (__bridge id)image.CGImage;
    //设置图片的填充属性 类似UIImage的contentMode
    //保持大小比例
    //    self.whiteView.layer.contentsGravity = kCAGravityResizeAspect;
    //不调整大小
    self.whiteView.layer.contentsGravity = kCAGravityCenter;
    //set the contesScale to match image
    self.whiteView.layer.contentsScale = image.scale;
    //不显示超出边界内容
    self.whiteView.layer.masksToBounds = true;
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
