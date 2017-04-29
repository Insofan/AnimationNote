//
//  ViewController.m
//  AnimationDemo
//
//  Created by 海啸 on 2017/4/28.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ViewController.h"
#import "TransitionViewController.h"
#import "BasicViewController.h"
#import "KeyFrameViewController.h"
#import "GroupViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *vcArray;
@end

@implementation ViewController

- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[@{@"title":@"1.转场动画 Transition View", @"class":[TransitionViewController class]}, @{@"title":@"2.基础动画 Basic View", @"class": [BasicViewController class]} , @{@"title":@"3.关键帧动画 Key Frame View", @"class": [KeyFrameViewController class]} , @{@"title":@"4.组动画 Group View", @"class": [GroupViewController class]}];
        
    }
    return _vcArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = self.vcArray[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *demoVC = [[self.vcArray[indexPath.row][@"class"] alloc] init];
    demoVC.title = self.vcArray[indexPath.row][@"title"];
    [self.navigationController pushViewController:demoVC animated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor randomColor];
    
    
}


@end
