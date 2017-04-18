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
@interface ViewController ()<CALayerDelegate>
@property (strong, nonatomic) UIView *whiteView;
//@property (weak, nonatomic) IBOutlet UIView *one;
//@property (weak, nonatomic) IBOutlet UIView *two;
//@property (weak, nonatomic) IBOutlet UIView *three;
//@property (weak, nonatomic) IBOutlet UIView *four;
//@property (weak, nonatomic) IBOutlet UIButton *button1;
//@property (weak, nonatomic) IBOutlet UIButton *button2;

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

//- (void)addSpriteImage:(UIImage *)image WithContentRect:(CGRect)rect toLayer:(CALayer *)layer {
//    layer.contents = (__bridge id)image.CGImage;
//    
//    //scale contents to fit 填充方式等比例
//    layer.contentsGravity = kCAGravityResizeAspect;
//    //set contentsRect
//    layer.contentsRect = rect;
//}

//- (void)addStretchImage:(UIImage *)image withContentCenter:(CGRect )rect toLayer:(CALayer *)layer {
//    //set image
//    layer.contents = (__bridge id)image.CGImage;
//    //set contentsCenter
//    layer.contentsCenter = rect;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //contents相关
    /*
    [self whiteView];
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
    */
    
    /*
     //contentsRect相关
     UIImage *image = [UIImage imageNamed:@"1"];
     [self addSpriteImage:image WithContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.one.layer];
     
     [self addSpriteImage:image WithContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.two.layer];
     
     [self addSpriteImage:image WithContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.three.layer];
     
     [self addSpriteImage:image WithContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.four.layer];
     */
    
    /*
    UIImage *image = [UIImage imageNamed:@"gakki2"];
    [self addStretchImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.button1.layer];
    [self addStretchImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:self.button2.layer];
    */
    
    //Custom draw
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.whiteView.layer addSublayer:blueLayer];
    //froce layer to redraw
    [blueLayer display];
    
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //draw a thick red circle
    //设置线的宽度
    CGContextSetLineWidth(ctx, 10);
    //stroke 划线的颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    //在rect里面画一个椭圆型
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
