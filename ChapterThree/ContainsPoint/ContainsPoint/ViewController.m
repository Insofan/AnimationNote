//
//  ViewController.m
//  ContainsPoint
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <HXTool.h>
@interface ViewController ()
@property (strong, nonatomic) UIView *whiteView;
@property (strong, nonatomic) CALayer *blueLayer;
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
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50, 50, 100, 100);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.whiteView.layer addSublayer:self.blueLayer];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //get touch position relative to main view,算出在self的点击position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    /*containsPoint方法
     //convert point to the white layer's coordinates,转换成白色涂层坐标系
     point = [self.whiteView.layer convertPoint:point fromLayer:self.view.layer];
     //get layer using contains point使用包含点方法,containsPoint 返回bool值
     if ([self.whiteView.layer containsPoint:point]) {
     //convert point to bluyeLayer's coordinates
     point = [self.blueLayer convertPoint:point fromLayer:self.whiteView.layer];
     if ([self.blueLayer containsPoint:point]) {
     [[[UIAlertView alloc] initWithTitle:@"Inside Blue" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     } else {
     [[[UIAlertView alloc] initWithTitle:@"Inside White" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }
     }
     */
    
    //hitTest方法,返回图层，返回图层本身或者包含这个点的字图层
    CALayer *layer = [self.view.layer hitTest:point];
    //get layer using hitTest
    if (layer == self.blueLayer) {
       [[[UIAlertView alloc] initWithTitle:@"Inside Blue" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else if (layer == self.whiteView.layer) {
       [[[UIAlertView alloc] initWithTitle:@"Inside White" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }else if(layer == self.view.layer) {
       [[[UIAlertView alloc] initWithTitle:@"Inside Background" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}



@end
