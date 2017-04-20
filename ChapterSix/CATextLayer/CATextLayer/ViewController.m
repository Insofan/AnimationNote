//
//  ViewController.m
//  CATextLayer
//
//  Created by 海啸 on 2017/4/19.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *labelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode   = kCAAlignmentJustified;
    textLayer.wrapped         = true;
    //textLayer 的scale默认并不是1，要设置一下
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //UIFont
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //Set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //text
    NSString *text = @"I have a dream today. I have a dream that one day every valley shall be exalted, every hill and mountain shall be made low, the rough places will...";
    
    textLayer.string = text;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
