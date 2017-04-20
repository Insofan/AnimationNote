//
//  ScrollView.m
//  CAScrollLayer
//
//  Created by 海啸 on 2017/4/20.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

+ (Class)layerClass {
    return [CAScrollLayer class];
}

- (void)setUp {
    //enable clipping
    self.layer.masksToBounds = true;
    
    //add attach pan gesture,拖动
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    return [self setUp];
}


- (void)pan:(UIPanGestureRecognizer *)recognizer {
    //get the offset by the pan gesture
    //translate from the current bounds origin
    CGPoint offset = self.bounds.origin;
    CGPoint translation = [recognizer translationInView:self];
    offset.x -= translation.x;
    offset.y -= translation.y;
    
    NSLog(@"translation: %@",NSStringFromCGPoint(translation));
    
    //scroll the view,滚动自身
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    //reset the gesture translation,重置
    [recognizer setTranslation:CGPointZero inView:self];
}

@end
