//
//  MyFloatLayout.m
//  MyLayout
//
//  Created by oybq on 16/2/18.
//  Copyright © 2016年 YoungSoft. All rights reserved.
//

#import "MyFloatLayout.h"
#import "MyLayoutInner.h"

@implementation  UIView(MyFloatLayoutExt)


-(void)setReverseFloat:(BOOL)reverseFloat
{
    if (self.myCurrentSizeClass.isReverseFloat != reverseFloat)
    {
        self.myCurrentSizeClass.reverseFloat = reverseFloat;
        if (self.superview != nil)
            [self.superview setNeedsLayout];
    }
}

-(BOOL)isReverseFloat
{
    return self.myCurrentSizeClass.isReverseFloat;
    
}

-(void)setClearFloat:(BOOL)clearFloat
{
    if (self.myCurrentSizeClass.clearFloat != clearFloat)
    {
        self.myCurrentSizeClass.clearFloat = clearFloat;
        if (self.superview != nil)
            [self.superview setNeedsLayout];
    }
}

-(BOOL)clearFloat
{
    return self.myCurrentSizeClass.clearFloat;
}


-(CGFloat)weight
{
    return self.myCurrentSizeClass.weight;
}

-(void)setWeight:(CGFloat)weight
{
    if (self.myCurrentSizeClass.weight != weight)
    {
        self.myCurrentSizeClass.weight = weight;
        if (self.superview != nil)
            [self.superview setNeedsLayout];
    }
}



@end




@implementation MyFloatLayout

-(instancetype)initWithFrame:(CGRect)frame orientation:(MyLayoutViewOrientation)orientation
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.myCurrentSizeClass.orientation = orientation;
    }
    
    return self;
}

-(instancetype)initWithOrientation:(MyLayoutViewOrientation)orientation
{
    return [self initWithFrame:CGRectZero orientation:orientation];
}


+(instancetype)floatLayoutWithOrientation:(MyLayoutViewOrientation)orientation
{
    MyFloatLayout *layout = [[[self class] alloc] initWithOrientation:orientation];
    return layout;
}

-(void)setOrientation:(MyLayoutViewOrientation)orientation
{
    MyFloatLayout *lsc = self.myCurrentSizeClass;
    if (lsc.orientation != orientation)
    {
        lsc.orientation = orientation;
        [self setNeedsLayout];
    }
}

-(MyLayoutViewOrientation)orientation
{
    return self.myCurrentSizeClass.orientation;
}


-(void)setGravity:(MyGravity)gravity
{
    MyFloatLayout *lsc = self.myCurrentSizeClass;
    if (lsc.gravity != gravity)
    {
        lsc.gravity = gravity;
        [self setNeedsLayout];
    }
}

-(MyGravity)gravity
{
    return self.myCurrentSizeClass.gravity;
}


-(void)setNoBoundaryLimit:(BOOL)noBoundaryLimit
{
    MyFloatLayout *lsc = self.myCurrentSizeClass;
    if (lsc.noBoundaryLimit != noBoundaryLimit)
    {
        lsc.noBoundaryLimit = noBoundaryLimit;
        [self setNeedsLayout];
    }
}

-(BOOL)noBoundaryLimit
{
    return self.myCurrentSizeClass.noBoundaryLimit;
}


-(void)setSubviewsSize:(CGFloat)subviewSize minSpace:(CGFloat)minSpace maxSpace:(CGFloat)maxSpace
{
    [self setSubviewsSize:subviewSize minSpace:minSpace maxSpace:maxSpace inSizeClass:MySizeClass_hAny | MySizeClass_wAny];
}

-(void)setSubviewsSize:(CGFloat)subviewSize minSpace:(CGFloat)minSpace maxSpace:(CGFloat)maxSpace inSizeClass:(MySizeClass)sizeClass
{
    MyFloatLayoutViewSizeClass *lsc = (MyFloatLayoutViewSizeClass*)[self fetchLayoutSizeClass:sizeClass];
    lsc.subviewSize = subviewSize;
    lsc.minSpace = minSpace;
    lsc.maxSpace = maxSpace;
    [self setNeedsLayout];
}


#pragma mark -- Deprecated Method


-(void)setSubviewFloatMargin:(CGFloat)subviewSize minMargin:(CGFloat)minMargin
{
    [self setSubviewsSize:subviewSize minSpace:minMargin maxSpace:CGFLOAT_MAX];
}

-(void)setSubviewFloatMargin:(CGFloat)subviewSize minMargin:(CGFloat)minMargin inSizeClass:(MySizeClass)sizeClass
{
    [self setSubviewsSize:subviewSize minSpace:minMargin maxSpace:CGFLOAT_MAX inSizeClass:sizeClass];
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


#pragma mark -- Override Method

-(CGSize)calcLayoutRect:(CGSize)size isEstimate:(BOOL)isEstimate pHasSubLayout:(BOOL*)pHasSubLayout sizeClass:(MySizeClass)sizeClass sbs:(NSMutableArray*)sbs
{
    CGSize selfSize = [super calcLayoutRect:size isEstimate:isEstimate pHasSubLayout:pHasSubLayout sizeClass:sizeClass sbs:sbs];
    
    if (sbs == nil)
        sbs = [self myGetLayoutSubviews];
    
    for (UIView *sbv in sbs)
    {
        if (!isEstimate)
        {
            sbv.myFrame.frame = sbv.bounds;
            [self myCalcSizeOfWrapContentSubview:sbv selfLayoutSize:selfSize];
        }
        
        if ([sbv isKindOfClass:[MyBaseLayout class]])
        {
            
            MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
            
            if (sbvl.wrapContentWidth)
            {
                if (sbvl.widthSizeInner.dimeVal != nil || (self.orientation == MyLayoutViewOrientation_Vert && sbvl.weight != 0))
                {
                    [sbvl mySetWrapContentWidthNoLayout:NO];
                }
            }
            
            if (sbvl.wrapContentHeight)
            {
                if (sbvl.heightSizeInner.dimeVal != nil || (self.orientation == MyLayoutViewOrientation_Horz && sbvl.weight != 0))
                {
                    [sbvl mySetWrapContentHeightNoLayout:NO];
                }
            }
            
            if (pHasSubLayout != nil && (sbvl.wrapContentHeight || sbvl.wrapContentWidth))
                *pHasSubLayout = YES;
                        
            if (isEstimate && (sbvl.wrapContentHeight || sbvl.wrapContentWidth))
            {
                [sbvl estimateLayoutRect:sbvl.myFrame.frame.size inSizeClass:sizeClass];
                sbvl.myFrame.sizeClass = [sbvl myBestSizeClass:sizeClass]; //因为estimateLayoutRect执行后会还原，所以这里要重新设置
            }
        }
    }
    
    
    if (self.orientation == MyLayoutViewOrientation_Vert)
        selfSize = [self myLayoutSubviewsForVert:selfSize sbs:sbs];
    else
        selfSize = [self myLayoutSubviewsForHorz:selfSize sbs:sbs];
    
    
    selfSize.height = [self myValidMeasure:self.heightSizeInner sbv:self calcSize:selfSize.height sbvSize:selfSize selfLayoutSize:self.superview.bounds.size];
    
    selfSize.width = [self myValidMeasure:self.widthSizeInner sbv:self calcSize:selfSize.width sbvSize:selfSize selfLayoutSize:self.superview.bounds.size];
    
    return [self myAdjustSizeWhenNoSubviews:selfSize sbs:sbs];
}

-(id)createSizeClassInstance
{
    return [MyFloatLayoutViewSizeClass new];
}

#pragma mark -- Private Method

-(CGPoint)myFindRightCandidatePoint:(CGRect)leftCandidateRect  width:(CGFloat)width rightBoundary:(CGFloat)rightBoundary rightCandidateRects:(NSArray*)rightCandidateRects hasWeight:(BOOL)hasWeight
{
    
    CGPoint retPoint = {rightBoundary,CGFLOAT_MAX};
    
    CGFloat lastHeight = self.topPadding;
    for (NSInteger i = rightCandidateRects.count - 1; i >= 0; i--)
    {
        
        CGRect rightCandidateRect = ((NSValue*)rightCandidateRects[i]).CGRectValue;
        
        //如果有比重则不能相等只能小于。
        if ((hasWeight ? CGRectGetMaxX(leftCandidateRect) + width < CGRectGetMinX(rightCandidateRect) : _myCGFloatLessOrEqual(CGRectGetMaxX(leftCandidateRect) + width, CGRectGetMinX(rightCandidateRect))
             ) &&
            CGRectGetMaxY(leftCandidateRect) > lastHeight)
        {
            retPoint.y = MAX(CGRectGetMinY(leftCandidateRect),lastHeight);
            retPoint.x = CGRectGetMinX(rightCandidateRect);
            break;
        }
        
        lastHeight = CGRectGetMaxY(rightCandidateRect);
        
    }
    
    if (retPoint.y == CGFLOAT_MAX)
    {
        if ((hasWeight ? CGRectGetMaxX(leftCandidateRect) + width < rightBoundary :_myCGFloatLessOrEqual(CGRectGetMaxX(leftCandidateRect) + width, rightBoundary) ) &&
            CGRectGetMaxY(leftCandidateRect) > lastHeight)
        {
            retPoint.y =  MAX(CGRectGetMinY(leftCandidateRect),lastHeight);
        }
    }
    
    return retPoint;
}

-(CGPoint)myFindBottomCandidatePoint:(CGRect)topCandidateRect  height:(CGFloat)height bottomBoundary:(CGFloat)bottomBoundary bottomCandidateRects:(NSArray*)bottomCandidateRects hasWeight:(BOOL)hasWeight
{
    
    CGPoint retPoint = {CGFLOAT_MAX,bottomBoundary};
    
    CGFloat lastWidth = self.leftPadding;
    for (NSInteger i = bottomCandidateRects.count - 1; i >= 0; i--)
    {
        
        CGRect bottomCandidateRect = ((NSValue*)bottomCandidateRects[i]).CGRectValue;
        if ((hasWeight ? CGRectGetMaxY(topCandidateRect) + height < CGRectGetMinY(bottomCandidateRect) :/* CGRectGetMaxY(topCandidateRect) + height <= CGRectGetMinY(bottomCandidateRect)*/
             _myCGFloatLessOrEqual(CGRectGetMaxY(topCandidateRect) + height, CGRectGetMinY(bottomCandidateRect))) &&
            CGRectGetMaxX(topCandidateRect) > lastWidth)
        {
            retPoint.x = MAX(CGRectGetMinX(topCandidateRect),lastWidth);
            retPoint.y = CGRectGetMinY(bottomCandidateRect);
            break;
        }
        
        lastWidth = CGRectGetMaxX(bottomCandidateRect);
        
    }
    
    if (retPoint.x == CGFLOAT_MAX)
    {
        if ((hasWeight ? CGRectGetMaxY(topCandidateRect) + height < bottomBoundary : /*CGRectGetMaxY(topCandidateRect) + height <= bottomBoundary*/_myCGFloatLessOrEqual(CGRectGetMaxY(topCandidateRect) + height, bottomBoundary) ) &&
            CGRectGetMaxX(topCandidateRect) > lastWidth)
        {
            retPoint.x =  MAX(CGRectGetMinX(topCandidateRect),lastWidth);
        }
    }
    
    return retPoint;
}


-(CGPoint)myFindLeftCandidatePoint:(CGRect)rightCandidateRect  width:(CGFloat)width leftBoundary:(CGFloat)leftBoundary leftCandidateRects:(NSArray*)leftCandidateRects hasWeight:(BOOL)hasWeight
{
    
    CGPoint retPoint = {leftBoundary,CGFLOAT_MAX};
    
    CGFloat lastHeight = self.topPadding;
    for (NSInteger i = leftCandidateRects.count - 1; i >= 0; i--)
    {
        
        CGRect leftCandidateRect = ((NSValue*)leftCandidateRects[i]).CGRectValue;
        if ((hasWeight ? CGRectGetMinX(rightCandidateRect) - width > CGRectGetMaxX(leftCandidateRect) : /*CGRectGetMinX(rightCandidateRect) - width >= CGRectGetMaxX(leftCandidateRect)*/
             _myCGFloatGreatOrEqual(CGRectGetMinX(rightCandidateRect) - width, CGRectGetMaxX(leftCandidateRect))) &&
            CGRectGetMaxY(rightCandidateRect) > lastHeight)
        {
            retPoint.y = MAX(CGRectGetMinY(rightCandidateRect),lastHeight);
            retPoint.x = CGRectGetMaxX(leftCandidateRect);
            break;
        }
        
        lastHeight = CGRectGetMaxY(leftCandidateRect);
        
    }
    
    if (retPoint.y == CGFLOAT_MAX)
    {
        if ((hasWeight ? CGRectGetMinX(rightCandidateRect) - width > leftBoundary : /*CGRectGetMinX(rightCandidateRect) - width >= leftBoundary*/
             _myCGFloatGreatOrEqual(CGRectGetMinX(rightCandidateRect) - width, leftBoundary)) &&
            CGRectGetMaxY(rightCandidateRect) > lastHeight)
        {
            retPoint.y =  MAX(CGRectGetMinY(rightCandidateRect),lastHeight);
        }
    }
    
    return retPoint;
}

-(CGPoint)myFindTopCandidatePoint:(CGRect)bottomCandidateRect  height:(CGFloat)height topBoundary:(CGFloat)topBoundary topCandidateRects:(NSArray*)topCandidateRects hasWeight:(BOOL)hasWeight
{
    
    CGPoint retPoint = {CGFLOAT_MAX, topBoundary};
    
    CGFloat lastWidth = self.leftPadding;
    for (NSInteger i = topCandidateRects.count - 1; i >= 0; i--)
    {
        
        CGRect topCandidateRect = ((NSValue*)topCandidateRects[i]).CGRectValue;
        if ((hasWeight ? CGRectGetMinY(bottomCandidateRect) - height > CGRectGetMaxY(topCandidateRect) : /*CGRectGetMinY(bottomCandidateRect) - height >= CGRectGetMaxY(topCandidateRect)*/
             _myCGFloatGreatOrEqual(CGRectGetMinY(bottomCandidateRect) - height, CGRectGetMaxY(topCandidateRect))) &&
            CGRectGetMaxX(bottomCandidateRect) > lastWidth)
        {
            retPoint.x = MAX(CGRectGetMinX(bottomCandidateRect),lastWidth);
            retPoint.y = CGRectGetMaxY(topCandidateRect);
            break;
        }
        
        lastWidth = CGRectGetMaxX(topCandidateRect);
        
    }
    
    if (retPoint.x == CGFLOAT_MAX)
    {
        if ((hasWeight ? CGRectGetMinY(bottomCandidateRect) - height > topBoundary : /*CGRectGetMinY(bottomCandidateRect) - height >= topBoundary*/
             _myCGFloatGreatOrEqual(CGRectGetMinY(bottomCandidateRect) - height, topBoundary)) &&
            CGRectGetMaxX(bottomCandidateRect) > lastWidth)
        {
            retPoint.x =  MAX(CGRectGetMinX(bottomCandidateRect),lastWidth);
        }
    }
    
    return retPoint;
}



-(CGSize)myLayoutSubviewsForVert:(CGSize)selfSize sbs:(NSArray*)sbs
{
    UIEdgeInsets padding = self.padding;
    BOOL hasBoundaryLimit = YES;
    if (self.wrapContentWidth && self.noBoundaryLimit)
        hasBoundaryLimit = NO;
    
    //如果没有边界限制我们将高度设置为最大。。
    if (!hasBoundaryLimit)
        selfSize.width = CGFLOAT_MAX;
    
    //CGFloat
    
    //遍历所有的子视图，查看是否有子视图的宽度会比视图自身要宽，如果有且有包裹属性则扩充自身的宽度
    if (self.wrapContentWidth && hasBoundaryLimit)
    {
        CGFloat maxContentWidth = selfSize.width - padding.left - padding.right;
        for (UIView *sbv in sbs)
        {
            CGFloat leftMargin = sbv.leftPosInner.margin;
            CGFloat rightMargin = sbv.rightPosInner.margin;
            CGRect rect = sbv.myFrame.frame;
            
            //因为这里是计算包裹宽度属性，所以只会计算那些设置了固定宽度的子视图
            
            //这里有可能设置了固定的宽度
            if (sbv.widthSizeInner.dimeNumVal != nil)
                rect.size.width = sbv.widthSizeInner.measure;
            
            //有可能宽度是和他的高度相等。
            if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == sbv.heightSizeInner)
            {
                if (sbv.heightSizeInner.dimeNumVal != nil)
                    rect.size.height = sbv.heightSizeInner.measure;
                
                if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == self.heightSizeInner)
                    rect.size.height = [sbv.heightSizeInner measureWith:(selfSize.height - padding.top - padding.bottom) ];
                
                rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
                
                rect.size.width = [sbv.widthSizeInner measureWith:rect.size.height];
            }
            
            rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:rect.size.width sbvSize:rect.size selfLayoutSize:selfSize];
            
            if (leftMargin + rect.size.width + rightMargin > maxContentWidth &&
                (sbv.widthSizeInner.dimeRelaVal == nil || sbv.widthSizeInner.dimeRelaVal != self.widthSizeInner)  &&
                sbv.weight == 0)
            {
                maxContentWidth = leftMargin + rect.size.width + rightMargin;
            }
        }
        
        selfSize.width = padding.left + maxContentWidth + padding.right;
    }
    
    //支持浮动水平间距。
    CGFloat vertSpace = self.subviewVSpace;
    CGFloat horzSpace = self.subviewHSpace;
    CGFloat subviewSize = ((MyFloatLayoutViewSizeClass*)self.myCurrentSizeClass).subviewSize;
    if (subviewSize != 0)
    {
        
#ifdef DEBUG
        //异常崩溃：当布局视图设置了noBoundaryLimit为YES时，不能设置最小垂直间距。
        NSCAssert(hasBoundaryLimit, @"Constraint exception！！, vertical float layout:%@ can not set noBoundaryLimit to YES when call setSubviewsSize:minSpace:maxSpace  method",self);
#endif
        
        
        CGFloat minSpace = ((MyFloatLayoutViewSizeClass*)self.myCurrentSizeClass).minSpace;
        CGFloat maxSpace = ((MyFloatLayoutViewSizeClass*)self.myCurrentSizeClass).maxSpace;
        
        NSInteger rowCount =  floor((selfSize.width - padding.left - padding.right  + minSpace) / (subviewSize + minSpace));
        if (rowCount > 1)
        {
            horzSpace = (selfSize.width - padding.left - padding.right - subviewSize * rowCount)/(rowCount - 1);
            
            //如果超过最大间距则调整子视图的宽度。
            if (horzSpace > maxSpace)
            {
                horzSpace = maxSpace;
                
                subviewSize =  (selfSize.width - padding.left - padding.right -  horzSpace * (rowCount - 1)) / rowCount;
                
            }
            
        }
    }
    
    
    //左边候选区域数组，保存的是CGRect值。
    NSMutableArray *leftCandidateRects = [NSMutableArray new];
    //为了计算方便总是把最左边的个虚拟区域作为一个候选区域
    [leftCandidateRects addObject:[NSValue valueWithCGRect:CGRectMake(padding.left, padding.top, 0, CGFLOAT_MAX)]];
    
    //右边候选区域数组，保存的是CGRect值。
    NSMutableArray *rightCandidateRects = [NSMutableArray new];
    //为了计算方便总是把最右边的个虚拟区域作为一个候选区域
    [rightCandidateRects addObject:[NSValue valueWithCGRect:CGRectMake(selfSize.width - padding.right, padding.top, 0, CGFLOAT_MAX)]];
    
    //分别记录左边和右边的最后一个视图在Y轴的偏移量
    CGFloat leftLastYOffset = padding.top;
    CGFloat rightLastYOffset = padding.top;
    
    //分别记录左右边和全局浮动视图的最高占用的Y轴的值
    CGFloat leftMaxHeight = padding.top;
    CGFloat rightMaxHeight = padding.top;
    CGFloat maxHeight = padding.top;
    CGFloat maxWidth = padding.left;
    
    for (UIView *sbv in sbs)
    {
        CGFloat topMargin = sbv.topPosInner.margin;
        CGFloat leftMargin = sbv.leftPosInner.margin;
        CGFloat bottomMargin = sbv.bottomPosInner.margin;
        CGFloat rightMargin = sbv.rightPosInner.margin;
        CGRect rect = sbv.myFrame.frame;
        
        
        if (subviewSize != 0)
            rect.size.width = subviewSize;
        
        if (sbv.widthSizeInner.dimeNumVal != nil)
            rect.size.width = sbv.widthSizeInner.measure;
        
        if (sbv.heightSizeInner.dimeNumVal != nil)
            rect.size.height = sbv.heightSizeInner.measure;
        
        if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == self.heightSizeInner && !self.wrapContentHeight)
            rect.size.height = [sbv.heightSizeInner measureWith:(selfSize.height - padding.top - padding.bottom) ];
        
        if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == self.widthSizeInner)
            rect.size.width = [sbv.widthSizeInner measureWith:(selfSize.width - padding.left - padding.right) ];
        
        rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:rect.size.width sbvSize:rect.size selfLayoutSize:selfSize];
        
        if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == sbv.widthSizeInner)
            rect.size.height = [sbv.heightSizeInner measureWith:rect.size.width];
        
        rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
        
        if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == sbv.heightSizeInner)
            rect.size.width = [sbv.widthSizeInner measureWith:rect.size.height ];
        
        if (sbv.widthSizeInner.dimeRelaVal != nil &&  sbv.widthSizeInner.dimeRelaVal.view != nil &&  sbv.widthSizeInner.dimeRelaVal.view != self && sbv.widthSizeInner.dimeRelaVal.view != sbv)
        {
            rect.size.width = [sbv.widthSizeInner measureWith:sbv.widthSizeInner.dimeRelaVal.view.estimatedRect.size.width];
        }
        
        if (sbv.heightSizeInner.dimeRelaVal != nil &&  sbv.heightSizeInner.dimeRelaVal.view != nil &&  sbv.heightSizeInner.dimeRelaVal.view != self && sbv.heightSizeInner.dimeRelaVal.view != sbv)
        {
            rect.size.height = [sbv.heightSizeInner measureWith:sbv.heightSizeInner.dimeRelaVal.view.estimatedRect.size.height];
        }
        
        rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:rect.size.width sbvSize:rect.size selfLayoutSize:selfSize];
        
        //如果高度是浮动的则需要调整高度。
        if (sbv.wrapContentHeight && ![sbv isKindOfClass:[MyBaseLayout class]])
            rect.size.height = [self myHeightFromFlexedHeightView:sbv inWidth:rect.size.width];
        
        rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
        
        
        if (sbv.reverseFloat)
        {
#ifdef DEBUG
            //异常崩溃：当布局视图设置了noBoundaryLimit为YES时子视图不能设置逆向浮动
            NSCAssert(hasBoundaryLimit, @"Constraint exception！！, vertical float layout:%@ can not set noBoundaryLimit to YES when the subview:%@ set reverseFloat to YES.",self, sbv);
#endif
            
            CGPoint nextPoint = {selfSize.width - padding.right, leftLastYOffset};
            CGFloat leftCandidateXBoundary = padding.left;
            if (sbv.clearFloat)
            {
                //找到最底部的位置。
                nextPoint.y = MAX(rightMaxHeight, leftLastYOffset);
                CGPoint leftPoint = [self myFindLeftCandidatePoint:CGRectMake(selfSize.width - padding.right, nextPoint.y, 0, CGFLOAT_MAX) width:leftMargin + (sbv.weight != 0 ? 0 : rect.size.width) + rightMargin leftBoundary:padding.left leftCandidateRects:leftCandidateRects hasWeight:NO];
                if (leftPoint.y != CGFLOAT_MAX)
                {
                    nextPoint.y = MAX(rightMaxHeight, leftPoint.y);
                    leftCandidateXBoundary = leftPoint.x;
                }
            }
            else
            {
                //依次从后往前，每个都比较右边的。
                for (NSInteger i = rightCandidateRects.count - 1; i >= 0; i--)
                {
                    CGRect candidateRect = ((NSValue*)rightCandidateRects[i]).CGRectValue;
                    CGPoint leftPoint = [self myFindLeftCandidatePoint:candidateRect width:leftMargin + (sbv.weight != 0 ? 0 : rect.size.width) + rightMargin leftBoundary:padding.left leftCandidateRects:leftCandidateRects hasWeight:sbv.weight != 0 ];
                    if (leftPoint.y != CGFLOAT_MAX)
                    {
                        nextPoint = CGPointMake(CGRectGetMinX(candidateRect), MAX(nextPoint.y, leftPoint.y));
                        leftCandidateXBoundary = leftPoint.x;
                        break;
                    }
                    
                    nextPoint.y = CGRectGetMaxY(candidateRect);
                }
            }
            
            //重新设置宽度
            if (sbv.weight != 0)
            {
                
                rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:(nextPoint.x - leftCandidateXBoundary + sbv.widthSizeInner.addVal) * sbv.weight - leftMargin - rightMargin sbvSize:rect.size selfLayoutSize:selfSize];
                
                
                if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == sbv.widthSizeInner)
                    rect.size.height = [sbv.heightSizeInner measureWith:rect.size.width];
                
                if (sbv.wrapContentHeight && ![sbv isKindOfClass:[MyBaseLayout class]])
                    rect.size.height = [self myHeightFromFlexedHeightView:sbv inWidth:rect.size.width];
                
                rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
                
            }
            
            
            rect.origin.x = nextPoint.x - rightMargin - rect.size.width;
            rect.origin.y = MIN(nextPoint.y, maxHeight) + topMargin;
            
            //如果有智能边界线则找出所有智能边界线。
            if (self.intelligentBorderline != nil)
            {
                //优先绘制左边和上边的。绘制左边的和上边的。
                if ([sbv isKindOfClass:[MyBaseLayout class]])
                {
                    MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
                    if (!sbvl.notUseIntelligentBorderline)
                    {
                        sbvl.bottomBorderline = nil;
                        sbvl.topBorderline = nil;
                        sbvl.rightBorderline = nil;
                        sbvl.leftBorderline = nil;
                        
                        
                        if (rect.origin.x + rect.size.width + rightMargin < selfSize.width - padding.right)
                        {
                            sbvl.rightBorderline = self.intelligentBorderline;
                        }
                        
                        if (rect.origin.y + rect.size.height + bottomMargin < selfSize.height - padding.bottom)
                        {
                            sbvl.bottomBorderline = self.intelligentBorderline;
                        }
                        
                        if (rect.origin.x > leftCandidateXBoundary && sbvl == sbs.lastObject)
                        {
                            sbvl.leftBorderline = self.intelligentBorderline;
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                }
            }
            
            
            //这里有可能子视图本身的宽度会超过布局视图本身，但是我们的候选区域则不存储超过的宽度部分。
            CGRect cRect = CGRectMake(MAX((rect.origin.x - leftMargin - horzSpace),padding.left), rect.origin.y - topMargin, MIN((rect.size.width + leftMargin + rightMargin),(selfSize.width - padding.left - padding.right)), rect.size.height + topMargin + bottomMargin + vertSpace);
            
            
            //把新的候选区域添加到数组中去。并删除高度小于新候选区域的其他区域
            for (NSInteger i = rightCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)rightCandidateRects[i]).CGRectValue;
                if (CGRectGetMaxY(candidateRect) <= CGRectGetMaxY(cRect))
                    [rightCandidateRects removeObjectAtIndex:i];
            }
            
            //删除左边高度小于新添加区域的顶部的候选区域
            for (NSInteger i = leftCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)leftCandidateRects[i]).CGRectValue;
                if (/*CGRectGetMaxY(candidateRect) <= CGRectGetMinY(cRect)*/
                    _myCGFloatLessOrEqual(CGRectGetMaxY(candidateRect), CGRectGetMinY(cRect)))
                    [leftCandidateRects removeObjectAtIndex:i];
            }
            
            
            [rightCandidateRects addObject:[NSValue valueWithCGRect:cRect]];
            rightLastYOffset = rect.origin.y - topMargin;
            
            if (rect.origin.y + rect.size.height + bottomMargin + vertSpace > rightMaxHeight)
                rightMaxHeight = rect.origin.y + rect.size.height + bottomMargin + vertSpace;
        }
        else
        {
            CGPoint nextPoint = {padding.left, rightLastYOffset};
            CGFloat rightCandidateXBoundary = selfSize.width - padding.right;
            
            //如果是清除了浮动则直换行移动到最下面。
            if (sbv.clearFloat)
            {
                //找到最低点。
                nextPoint.y = MAX(leftMaxHeight, rightLastYOffset);
                
                CGPoint rightPoint = [self myFindRightCandidatePoint:CGRectMake(padding.left, nextPoint.y, 0, CGFLOAT_MAX) width:leftMargin + (sbv.weight != 0 ? 0 : rect.size.width) + rightMargin rightBoundary:rightCandidateXBoundary rightCandidateRects:rightCandidateRects hasWeight:NO ];
                if (rightPoint.y != CGFLOAT_MAX)
                {
                    nextPoint.y = MAX(leftMaxHeight, rightPoint.y);
                    rightCandidateXBoundary = rightPoint.x;
                }
            }
            else
            {
                
                //依次从后往前，每个都比较右边的。
                for (NSInteger i = leftCandidateRects.count - 1; i >= 0; i--)
                {
                    CGRect candidateRect = ((NSValue*)leftCandidateRects[i]).CGRectValue;
                    CGPoint rightPoint = [self myFindRightCandidatePoint:candidateRect width:leftMargin + (sbv.weight != 0 ? 0 : rect.size.width) + rightMargin rightBoundary:selfSize.width - padding.right rightCandidateRects:rightCandidateRects hasWeight:sbv.weight != 0 ];
                    if (rightPoint.y != CGFLOAT_MAX)
                    {
                        nextPoint = CGPointMake(CGRectGetMaxX(candidateRect), MAX(nextPoint.y, rightPoint.y));
                        rightCandidateXBoundary = rightPoint.x;
                        break;
                    }
                    
                    nextPoint.y = CGRectGetMaxY(candidateRect);
                }
            }
            
            //重新设置宽度
            if (sbv.weight != 0)
            {
#ifdef DEBUG
                //异常崩溃：当布局视图设置了noBoundaryLimit为YES时子视图不能设置weight大于0
                NSCAssert(hasBoundaryLimit, @"Constraint exception！！, vertical float layout:%@ can not set noBoundaryLimit to YES when the subview:%@ set weight big than zero.",self, sbv);
#endif
                
                rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:(rightCandidateXBoundary - nextPoint.x + sbv.widthSizeInner.addVal) * sbv.weight - leftMargin - rightMargin sbvSize:rect.size selfLayoutSize:selfSize];
                
                if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == sbv.widthSizeInner)
                    rect.size.height = [sbv.heightSizeInner measureWith:rect.size.width];
                
                if (sbv.wrapContentHeight && ![sbv isKindOfClass:[MyBaseLayout class]])
                    rect.size.height = [self myHeightFromFlexedHeightView:sbv inWidth:rect.size.width];
                
                rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
                
            }
            
            rect.origin.x = nextPoint.x + leftMargin;
            rect.origin.y = MIN(nextPoint.y,maxHeight) + topMargin;
            
            if (self.intelligentBorderline != nil)
            {
                //优先绘制左边和上边的。绘制左边的和上边的。
                if ([sbv isKindOfClass:[MyBaseLayout class]])
                {
                    MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
                    
                    if (!sbvl.notUseIntelligentBorderline)
                    {
                        sbvl.bottomBorderline = nil;
                        sbvl.topBorderline = nil;
                        sbvl.rightBorderline = nil;
                        sbvl.leftBorderline = nil;
                        
                        if (rect.origin.x + rect.size.width + rightMargin < selfSize.width - padding.right)
                        {
                            sbvl.rightBorderline = self.intelligentBorderline;
                        }
                        
                        if (rect.origin.y + rect.size.height + bottomMargin < selfSize.height - padding.bottom)
                        {
                            sbvl.bottomBorderline = self.intelligentBorderline;
                        }
                        
                        
                    }
                    
                }
            }
            
            
            CGRect cRect = CGRectMake(rect.origin.x - leftMargin, rect.origin.y - topMargin, MIN((rect.size.width + leftMargin + rightMargin + horzSpace),(selfSize.width - padding.left - padding.right)), rect.size.height + topMargin + bottomMargin + vertSpace);
            
            
            //把新添加到候选中去。并删除高度小于的候选键。和高度
            for (NSInteger i = leftCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)leftCandidateRects[i]).CGRectValue;
                if (/*CGRectGetMaxY(candidateRect) <= CGRectGetMaxY(cRect)*/
                    _myCGFloatLessOrEqual(CGRectGetMaxY(candidateRect), CGRectGetMaxY(cRect)))
                    [leftCandidateRects removeObjectAtIndex:i];
            }
            
            //删除右边高度小于新添加区域的顶部的候选区域
            for (NSInteger i = rightCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)rightCandidateRects[i]).CGRectValue;
                if (/*CGRectGetMaxY(candidateRect) <= CGRectGetMinY(cRect)*/
                    _myCGFloatLessOrEqual(CGRectGetMaxY(candidateRect), CGRectGetMinY(cRect)))
                    [rightCandidateRects removeObjectAtIndex:i];
            }
            
            [leftCandidateRects addObject:[NSValue valueWithCGRect:cRect]];
            leftLastYOffset = rect.origin.y - topMargin;
            
            if (rect.origin.y + rect.size.height + bottomMargin + vertSpace > leftMaxHeight)
                leftMaxHeight = rect.origin.y + rect.size.height + bottomMargin + vertSpace;
            
        }
        
        if (rect.origin.y + rect.size.height + bottomMargin + vertSpace > maxHeight)
            maxHeight = rect.origin.y + rect.size.height + bottomMargin + vertSpace;
        
        if (rect.origin.x + rect.size.width + rightMargin + horzSpace > maxWidth)
            maxWidth = rect.origin.x + rect.size.width + rightMargin + horzSpace;
        
        sbv.myFrame.frame = rect;
        
    }
    
    if (sbs.count > 0)
    {
        maxHeight -= vertSpace;
        maxWidth -= horzSpace;
    }
    
    maxHeight += padding.bottom;
    maxWidth += padding.right;
    
    if (!hasBoundaryLimit)
        selfSize.width = maxWidth;
    
    if (self.wrapContentHeight)
        selfSize.height = maxHeight;
    else
    {
        CGFloat addYPos = 0;
        MyGravity mgvert = self.gravity & MyGravity_Horz_Mask;
        if (mgvert == MyGravity_Vert_Center)
        {
            addYPos = (selfSize.height - maxHeight) / 2;
        }
        else if (mgvert == MyGravity_Vert_Bottom)
        {
            addYPos = selfSize.height - maxHeight;
        }
        
        if (addYPos != 0)
        {
            for (int i = 0; i < sbs.count; i++)
            {
                UIView *sbv = sbs[i];
                
                sbv.myFrame.topPos += addYPos;
            }
        }
        
    }
    
    return selfSize;
}

-(CGSize)myLayoutSubviewsForHorz:(CGSize)selfSize sbs:(NSArray*)sbs
{
    UIEdgeInsets padding = self.padding;
    BOOL hasBoundaryLimit = YES;
    if (self.wrapContentHeight && self.noBoundaryLimit)
        hasBoundaryLimit = NO;
    
    //如果没有边界限制我们将高度设置为最大。。
    if (!hasBoundaryLimit)
        selfSize.height = CGFLOAT_MAX;
    
    //遍历所有的子视图，查看是否有子视图的宽度会比视图自身要宽，如果有且有包裹属性则扩充自身的宽度
    if (self.wrapContentHeight && hasBoundaryLimit)
    {
        CGFloat maxContentHeight = selfSize.height - padding.top - padding.bottom;
        for (UIView *sbv in sbs)
        {
            CGFloat topMargin = sbv.topPosInner.margin;
            CGFloat bottomMargin = sbv.bottomPosInner.margin;
            CGRect rect = sbv.myFrame.frame;
            
            
            //这里有可能设置了固定的高度
            if (sbv.heightSizeInner.dimeNumVal != nil)
                rect.size.height = sbv.heightSizeInner.measure;
            
            rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:rect.size.width sbvSize:rect.size selfLayoutSize:selfSize];
            
            //有可能高度是和他的宽度相等。
            if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == sbv.widthSizeInner)
            {
                if (sbv.widthSizeInner.dimeNumVal != nil)
                    rect.size.width = sbv.widthSizeInner.measure;
                
                if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == self.widthSizeInner)
                    rect.size.width = [sbv.widthSizeInner measureWith:(selfSize.width - padding.left - padding.right) ];
                
                rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:rect.size.width sbvSize:rect.size selfLayoutSize:selfSize];
                
                
                rect.size.height = [sbv.heightSizeInner measureWith:rect.size.width];
            }
            
            if (sbv.wrapContentHeight && ![sbv isKindOfClass:[MyBaseLayout class]])
                rect.size.height = [self myHeightFromFlexedHeightView:sbv inWidth:rect.size.width];
            
            rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
            
            if (topMargin + rect.size.height + bottomMargin > maxContentHeight &&
                (sbv.heightSizeInner.dimeRelaVal == nil || sbv.heightSizeInner.dimeRelaVal != self.heightSizeInner) &&
                sbv.weight == 0)
            {
                maxContentHeight = topMargin + rect.size.height + bottomMargin;
            }
        }
        
        selfSize.height = padding.top + maxContentHeight + padding.bottom;
    }
    
    //支持浮动垂直间距。
    CGFloat horzSpace = self.subviewHSpace;
    CGFloat vertSpace = self.subviewVSpace;
    CGFloat subviewSize = ((MyFloatLayoutViewSizeClass*)self.myCurrentSizeClass).subviewSize;
    if (subviewSize != 0)
    {
#ifdef DEBUG
        //异常崩溃：当布局视图设置了noBoundaryLimit为YES时，不能设置最小垂直间距。
        NSCAssert(hasBoundaryLimit, @"Constraint exception！！, horizontal float layout:%@ can not set noBoundaryLimit to YES when call setSubviewsSize:minSpace:maxSpace  method",self);
#endif
        
        CGFloat minSpace = ((MyFloatLayoutViewSizeClass*)self.myCurrentSizeClass).minSpace;
        CGFloat maxSpace = ((MyFloatLayoutViewSizeClass*)self.myCurrentSizeClass).maxSpace;
        
        NSInteger rowCount =  floor((selfSize.height - padding.top - padding.bottom  + minSpace) / (subviewSize + minSpace));
        if (rowCount > 1)
        {
            vertSpace = (selfSize.height - padding.top - padding.bottom - subviewSize * rowCount)/(rowCount - 1);
            
            if (vertSpace > maxSpace)
            {
                vertSpace = maxSpace;
                
                subviewSize =  (selfSize.height - padding.top - padding.bottom -  vertSpace * (rowCount - 1)) / rowCount;
                
            }
            
        }
    }
    
    
    //上边候选区域数组，保存的是CGRect值。
    NSMutableArray *topCandidateRects = [NSMutableArray new];
    //为了计算方便总是把最上边的个虚拟区域作为一个候选区域
    [topCandidateRects addObject:[NSValue valueWithCGRect:CGRectMake(padding.left, padding.top,CGFLOAT_MAX,0)]];
    
    //右边候选区域数组，保存的是CGRect值。
    NSMutableArray *bottomCandidateRects = [NSMutableArray new];
    //为了计算方便总是把最下边的个虚拟区域作为一个候选区域,如果没有边界限制则
    [bottomCandidateRects addObject:[NSValue valueWithCGRect:CGRectMake(padding.left, selfSize.height - padding.bottom, CGFLOAT_MAX, 0)]];
    
    //分别记录上边和下边的最后一个视图在X轴的偏移量
    CGFloat topLastXOffset = padding.left;
    CGFloat bottomLastXOffset = padding.left;
    
    //分别记录上下边和全局浮动视图的最宽占用的X轴的值
    CGFloat topMaxWidth = padding.left;
    CGFloat bottomMaxWidth = padding.left;
    CGFloat maxWidth = padding.left;
    CGFloat maxHeight = padding.top;
    
    for (UIView *sbv in sbs)
    {
        CGFloat topMargin = sbv.topPosInner.margin;
        CGFloat leftMargin = sbv.leftPosInner.margin;
        CGFloat bottomMargin = sbv.bottomPosInner.margin;
        CGFloat rightMargin = sbv.rightPosInner.margin;
        CGRect rect = sbv.myFrame.frame;
        
        if (sbv.widthSizeInner.dimeNumVal != nil)
            rect.size.width = sbv.widthSizeInner.measure;
        
        if (subviewSize != 0)
            rect.size.height = subviewSize;
        
        if (sbv.heightSizeInner.dimeNumVal != nil)
            rect.size.height = sbv.heightSizeInner.measure;
        
        if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == self.heightSizeInner)
            rect.size.height = [sbv.heightSizeInner measureWith:(selfSize.height - padding.top - padding.bottom) ];
        
        if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == self.widthSizeInner && !self.wrapContentWidth)
            rect.size.width = [sbv.widthSizeInner measureWith:(selfSize.width - padding.left - padding.right) ];
        
        rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:rect.size.width sbvSize:rect.size selfLayoutSize:selfSize];
        
        if (sbv.heightSizeInner.dimeRelaVal != nil && sbv.heightSizeInner.dimeRelaVal == sbv.widthSizeInner)
            rect.size.height = [sbv.heightSizeInner measureWith:rect.size.width];
        
        
        rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
        
        if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == sbv.heightSizeInner)
            rect.size.width = [sbv.widthSizeInner measureWith:rect.size.height];
        
        if (sbv.widthSizeInner.dimeRelaVal != nil &&  sbv.widthSizeInner.dimeRelaVal.view != nil &&  sbv.widthSizeInner.dimeRelaVal.view != self && sbv.widthSizeInner.dimeRelaVal.view != sbv)
        {
            rect.size.width = [sbv.widthSizeInner measureWith:sbv.widthSizeInner.dimeRelaVal.view.estimatedRect.size.width];
        }
        
        if (sbv.heightSizeInner.dimeRelaVal != nil &&  sbv.heightSizeInner.dimeRelaVal.view != nil &&  sbv.heightSizeInner.dimeRelaVal.view != self && sbv.heightSizeInner.dimeRelaVal.view != sbv)
        {
            rect.size.height = [sbv.heightSizeInner measureWith:sbv.heightSizeInner.dimeRelaVal.view.estimatedRect.size.height];
        }
        
        rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:rect.size.width sbvSize:rect.size selfLayoutSize:selfSize];
        
        
        //如果高度是浮动的则需要调整高度。
        if (sbv.wrapContentHeight && ![sbv isKindOfClass:[MyBaseLayout class]])
            rect.size.height = [self myHeightFromFlexedHeightView:sbv inWidth:rect.size.width];
        
        rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:rect.size.height sbvSize:rect.size selfLayoutSize:selfSize];
        
        
        
        if (sbv.reverseFloat)
        {
#ifdef DEBUG
            //异常崩溃：当布局视图设置了noBoundaryLimit为YES时子视图不能设置逆向浮动
            NSCAssert(hasBoundaryLimit, @"Constraint exception！！, horizontal float layout:%@ can not set noBoundaryLimit to YES when the subview:%@ set reverseFloat to YES.",self, sbv);
#endif
            
            CGPoint nextPoint = {topLastXOffset, selfSize.height - padding.bottom};
            CGFloat topCandidateYBoundary = padding.top;
            if (sbv.clearFloat)
            {
                //找到最底部的位置。
                nextPoint.x = MAX(bottomMaxWidth, topLastXOffset);
                CGPoint topPoint = [self myFindTopCandidatePoint:CGRectMake(nextPoint.x, selfSize.height - padding.bottom, CGFLOAT_MAX, 0) height:topMargin + (sbv.weight != 0 ? 0 : rect.size.height) + bottomMargin topBoundary:topCandidateYBoundary topCandidateRects:topCandidateRects hasWeight:NO ];
                if (topPoint.x != CGFLOAT_MAX)
                {
                    nextPoint.x = MAX(bottomMaxWidth, topPoint.x);
                    topCandidateYBoundary = topPoint.y;
                }
            }
            else
            {
                //依次从后往前，每个都比较右边的。
                for (NSInteger i = bottomCandidateRects.count - 1; i >= 0; i--)
                {
                    CGRect candidateRect = ((NSValue*)bottomCandidateRects[i]).CGRectValue;
                    CGPoint topPoint = [self myFindTopCandidatePoint:candidateRect height:topMargin + (sbv.weight != 0 ? 0 : rect.size.height) + bottomMargin topBoundary:padding.top topCandidateRects:topCandidateRects hasWeight:sbv.weight != 0 ];
                    if (topPoint.x != CGFLOAT_MAX)
                    {
                        nextPoint = CGPointMake(MAX(nextPoint.x, topPoint.x),CGRectGetMinY(candidateRect));
                        topCandidateYBoundary = topPoint.y;
                        break;
                    }
                    
                    nextPoint.x = CGRectGetMaxX(candidateRect);
                }
            }
            
            if (sbv.weight != 0)
            {
                rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:(nextPoint.y - topCandidateYBoundary + sbv.heightSizeInner.addVal) * sbv.weight - topMargin - bottomMargin sbvSize:rect.size selfLayoutSize:selfSize];
                
                if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == sbv.heightSizeInner)
                    rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:[sbv.widthSizeInner measureWith: rect.size.height] sbvSize:rect.size selfLayoutSize:selfSize];
                
            }
            
            
            rect.origin.y = nextPoint.y - bottomMargin - rect.size.height;
            rect.origin.x = MIN(nextPoint.x, maxWidth) + leftMargin;
            
            //如果有智能边界线则找出所有智能边界线。
            if (self.intelligentBorderline != nil)
            {
                //优先绘制左边和上边的。绘制左边的和上边的。
                if ([sbv isKindOfClass:[MyBaseLayout class]])
                {
                    MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
                    
                    if (!sbvl.notUseIntelligentBorderline)
                    {
                        sbvl.bottomBorderline = nil;
                        sbvl.topBorderline = nil;
                        sbvl.rightBorderline = nil;
                        sbvl.leftBorderline = nil;
                        
                        //如果自己的上边和左边有子视图。
                        if (rect.origin.x + rect.size.width + rightMargin < selfSize.width - padding.right)
                        {
                            sbvl.rightBorderline = self.intelligentBorderline;
                        }
                        
                        if (rect.origin.y + rect.size.height + bottomMargin < selfSize.height - padding.bottom)
                        {
                            sbvl.bottomBorderline = self.intelligentBorderline;
                        }
                        
                        if (rect.origin.y > topCandidateYBoundary && sbvl == sbs.lastObject)
                        {
                            sbvl.topBorderline = self.intelligentBorderline;
                        }
                        
                    }
                    
                }
            }
            
            
            //这里有可能子视图本身的高度会超过布局视图本身，但是我们的候选区域则不存储超过的高度部分。
            CGRect cRect = CGRectMake(rect.origin.x - leftMargin, MAX((rect.origin.y - topMargin - vertSpace),padding.top), rect.size.width + leftMargin + rightMargin + horzSpace, MIN((rect.size.height + topMargin + bottomMargin),(selfSize.height - padding.top - padding.bottom)));
            
            //把新的候选区域添加到数组中去。并删除高度小于新候选区域的其他区域
            for (NSInteger i = bottomCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)bottomCandidateRects[i]).CGRectValue;
                if (/*CGRectGetMaxX(candidateRect) <= CGRectGetMaxX(cRect)*/
                    _myCGFloatLessOrEqual(CGRectGetMaxX(candidateRect), CGRectGetMaxX(cRect)))
                    [bottomCandidateRects removeObjectAtIndex:i];
            }
            
            //删除顶部宽度小于新添加区域的顶部的候选区域
            for (NSInteger i = topCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)topCandidateRects[i]).CGRectValue;
                if (/*CGRectGetMaxX(candidateRect) <= CGRectGetMinX(cRect)*/
                    _myCGFloatLessOrEqual(CGRectGetMaxX(candidateRect), CGRectGetMinX(cRect)))
                    [topCandidateRects removeObjectAtIndex:i];
            }
            
            [bottomCandidateRects addObject:[NSValue valueWithCGRect:cRect]];
            bottomLastXOffset = rect.origin.x - leftMargin;
            
            if (rect.origin.x + rect.size.width + rightMargin + horzSpace > bottomMaxWidth)
                bottomMaxWidth = rect.origin.x + rect.size.width + rightMargin + horzSpace;
        }
        else
        {
            CGPoint nextPoint = {bottomLastXOffset,padding.top};
            CGFloat bottomCandidateYBoundary = selfSize.height - padding.bottom;
            //如果是清除了浮动则直换行移动到最下面。
            if (sbv.clearFloat)
            {
                //找到最低点。
                nextPoint.x = MAX(topMaxWidth, bottomLastXOffset);
                
                CGPoint bottomPoint = [self myFindBottomCandidatePoint:CGRectMake(nextPoint.x, padding.top,CGFLOAT_MAX,0) height:topMargin + (sbv.weight != 0 ? 0: rect.size.height) + bottomMargin bottomBoundary:bottomCandidateYBoundary bottomCandidateRects:bottomCandidateRects hasWeight:NO];
                if (bottomPoint.x != CGFLOAT_MAX)
                {
                    nextPoint.x = MAX(topMaxWidth, bottomPoint.x);
                    bottomCandidateYBoundary = bottomPoint.y;
                }
            }
            else
            {
                
                //依次从后往前，每个都比较右边的。
                for (NSInteger i = topCandidateRects.count - 1; i >= 0; i--)
                {
                    CGRect candidateRect = ((NSValue*)topCandidateRects[i]).CGRectValue;
                    CGPoint bottomPoint = [self myFindBottomCandidatePoint:candidateRect height:topMargin + (sbv.weight != 0 ? 0: rect.size.height) + bottomMargin bottomBoundary:selfSize.height - padding.bottom bottomCandidateRects:bottomCandidateRects hasWeight:sbv.weight != 0];
                    if (bottomPoint.x != CGFLOAT_MAX)
                    {
                        nextPoint = CGPointMake(MAX(nextPoint.x, bottomPoint.x),CGRectGetMaxY(candidateRect));
                        bottomCandidateYBoundary = bottomPoint.y;
                        break;
                    }
                    
                    nextPoint.x = CGRectGetMaxX(candidateRect);
                }
            }
            
            if (sbv.weight != 0)
            {
                
#ifdef DEBUG
                //异常崩溃：当布局视图设置了noBoundaryLimit为YES时子视图不能设置weight大于0
                NSCAssert(hasBoundaryLimit, @"Constraint exception！！, horizontal float layout:%@ can not set noBoundaryLimit to YES when the subview:%@ set weight big than zero.",self, sbv);
#endif
                
                rect.size.height = [self myValidMeasure:sbv.heightSizeInner sbv:sbv calcSize:(bottomCandidateYBoundary - nextPoint.y + sbv.heightSizeInner.addVal) * sbv.weight - topMargin - bottomMargin sbvSize:rect.size selfLayoutSize:selfSize];
                
                if (sbv.widthSizeInner.dimeRelaVal != nil && sbv.widthSizeInner.dimeRelaVal == sbv.heightSizeInner)
                    rect.size.width = [self myValidMeasure:sbv.widthSizeInner sbv:sbv calcSize:[sbv.widthSizeInner measureWith: rect.size.height] sbvSize:rect.size selfLayoutSize:selfSize];
                
            }
            
            rect.origin.y = nextPoint.y + topMargin;
            rect.origin.x = MIN(nextPoint.x,maxWidth) + leftMargin;
            
            //如果有智能边界线则找出所有智能边界线。
            if (self.intelligentBorderline != nil)
            {
                //优先绘制左边和上边的。绘制左边的和上边的。
                if ([sbv isKindOfClass:[MyBaseLayout class]])
                {
                    MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
                    if (!sbvl.notUseIntelligentBorderline)
                    {
                        sbvl.bottomBorderline = nil;
                        sbvl.topBorderline = nil;
                        sbvl.rightBorderline = nil;
                        sbvl.leftBorderline = nil;
                        
                        //如果自己的上边和左边有子视图。
                        if (rect.origin.x + rect.size.width + rightMargin < selfSize.width - padding.right)
                        {
                            sbvl.rightBorderline = self.intelligentBorderline;
                        }
                        
                        if (rect.origin.y + rect.size.height + bottomMargin <  selfSize.height - padding.bottom)
                        {
                            sbvl.bottomBorderline = self.intelligentBorderline;
                        }
                    }
                    
                }
            }
            
            
            CGRect cRect = CGRectMake(rect.origin.x - leftMargin, rect.origin.y - topMargin,rect.size.width + leftMargin + rightMargin + horzSpace,MIN((rect.size.height + topMargin + bottomMargin + vertSpace),(selfSize.height - padding.top - padding.bottom)));
            
            
            //把新添加到候选中去。并删除宽度小于的最新候选区域的候选区域
            for (NSInteger i = topCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)topCandidateRects[i]).CGRectValue;
                if (/*CGRectGetMaxX(candidateRect) <= CGRectGetMaxX(cRect)*/
                    _myCGFloatLessOrEqual(CGRectGetMaxX(candidateRect), CGRectGetMaxX(cRect)))
                    [topCandidateRects removeObjectAtIndex:i];
            }
            
            //删除顶部宽度小于新添加区域的顶部的候选区域
            for (NSInteger i = bottomCandidateRects.count - 1; i >= 0; i--)
            {
                CGRect candidateRect = ((NSValue*)bottomCandidateRects[i]).CGRectValue;
                if (/*CGRectGetMaxX(candidateRect) <= CGRectGetMinX(cRect)*/
                    _myCGFloatLessOrEqual(CGRectGetMaxX(candidateRect), CGRectGetMinX(cRect)))
                    [bottomCandidateRects removeObjectAtIndex:i];
            }
            
            
            [topCandidateRects addObject:[NSValue valueWithCGRect:cRect]];
            topLastXOffset = rect.origin.x - leftMargin;
            
            if (rect.origin.x + rect.size.width + rightMargin + horzSpace > topMaxWidth)
                topMaxWidth = rect.origin.x + rect.size.width + rightMargin + horzSpace;
            
        }
        
        if (rect.origin.x + rect.size.width + rightMargin + horzSpace > maxWidth)
            maxWidth = rect.origin.x + rect.size.width + rightMargin + horzSpace;
        
        if (rect.origin.y + rect.size.height + bottomMargin + vertSpace > maxHeight)
            maxHeight = rect.origin.y + rect.size.height + bottomMargin + vertSpace;
        
        sbv.myFrame.frame = rect;
        
    }
    
    if (sbs.count > 0)
    {
        maxWidth -= horzSpace;
        maxHeight -= vertSpace;
    }
    
    maxWidth += padding.right;
    
    maxHeight += padding.bottom;
    if (!hasBoundaryLimit)
        selfSize.height = maxHeight;
    
    if (self.wrapContentWidth)
        selfSize.width = maxWidth;
    else
    {
        CGFloat addXPos = 0;
        MyGravity mghorz = self.gravity & MyGravity_Vert_Mask;
        if (mghorz == MyGravity_Horz_Center)
        {
            addXPos = (selfSize.width - maxWidth) / 2;
        }
        else if (mghorz == MyGravity_Horz_Right)
        {
            addXPos = selfSize.width - maxWidth;
        }
        
        if (addXPos != 0)
        {
            for (int i = 0; i < sbs.count; i++)
            {
                UIView *sbv = sbs[i];
                
                sbv.myFrame.leftPos += addXPos;
            }
        }
        
    }
    
    
    return selfSize;
}


@end
