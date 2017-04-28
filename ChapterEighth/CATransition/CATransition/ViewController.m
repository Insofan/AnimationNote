//
//  ViewController.m
//  CATransition
//
//  Created by 海啸 on 2017/4/24.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (copy, nonatomic) NSArray *images;

@end

@implementation ViewController
- (IBAction)switchImage:(id)sender {
    //设置过渡属性
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    //appply transition to imageview backing layer
    [self.imageView.layer addAnimation:transition forKey:nil];
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView.image = self.images[index];
    
    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        UIImage *currentImage = self.imageView.image;
        NSUInteger index = [self.images indexOfObject:currentImage];
        index = (index + 1)% [self.images count];
        self.imageView.image = self.images[index];
    } completion:nil
     ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.images = @[[UIImage imageNamed:@"Anchor"],[UIImage imageNamed:@"Cone"], [UIImage imageNamed:@"Igloo"]];
}



@end
