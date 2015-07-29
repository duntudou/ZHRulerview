//
//  ZHRulerView.m
//  MyrulerView
//
//  Created by mac on 15-1-5.
//  Copyright (c) 2015年 zhz. All rights reserved.
//

#import "ZHRulerView.h"

//rulerView的宽度或高度
static  CGFloat const rulerViewWOH=1.2;
//红色指针的高度
static  CGFloat const pointViewH=23;
@interface ZHRulerView ()<UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger mixNuber;
@property(nonatomic,assign)NSInteger maxNuber;
@property(nonatomic,assign)rulerViewShowType showType;

@property(nonatomic,weak)UIView *pointerView;
@property(nonatomic,assign)NSInteger rulerMultiple;
@end

@implementation ZHRulerView

-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(rulerViewShowType)showType rulerMultiple:(NSInteger)rulerMultiple{
    
    if (self=[super init]) {
        self.clipsToBounds=YES;
        _round=NO;
        _mixNuber=mixNuber;
        _maxNuber=maxNuber;
        _showType=showType;
        _rulerMultiple=rulerMultiple;
        
        //添加scroollView
        ZHRulerScrollView *rulerView= [[ZHRulerScrollView alloc] initWithMixNuber:_mixNuber maxNuber:_maxNuber showType:_showType rulerMultiple:rulerMultiple];
        rulerView.delegate=self;
        _rulerView=rulerView;
      [self addSubview:rulerView];
        //添加指针view
        UIView *pointerView=[[UIView alloc] init];
        pointerView.backgroundColor=[UIColor redColor];
        _pointerView=pointerView;
        [self addSubview:pointerView];
    }
    return self;
}

-(void)setDefaultVaule:(CGFloat)defaultVaule{
    
    UIImage *ruleImage=[UIImage imageNamed:@"ruler_weight"];
    CGFloat formlength=ruleImage.size.width/_rulerMultiple;
    CGFloat gapValue=(defaultVaule-_mixNuber+((CGFloat)_rulerMultiple/2))*formlength;
    if (_showType==rulerViewshowHorizontalType) {
        _rulerView.contentOffset=CGPointMake(gapValue, 0);
    }else{
        _rulerView.contentOffset=CGPointMake(0, gapValue);
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (_showType==rulerViewshowHorizontalType) {//如果是水平
        CGFloat pointerViewW=rulerViewWOH;
        CGFloat pointerViewH=pointViewH;
        CGFloat pointerViewX=(self.frame.size.width-pointerViewW)/2;
        CGFloat pointerViewY=0;
        _pointerView.frame=CGRectMake(pointerViewX, pointerViewY, pointerViewW, pointerViewH);
        _rulerView.frame=CGRectMake(self.frame.size.width/2, 0, rulerViewWOH, self.frame.size.height);
    }else {
        CGFloat pointerViewW=pointViewH;
        CGFloat pointerViewH=rulerViewWOH;
        CGFloat pointerViewX=0;
        CGFloat pointerViewY=(self.frame.size.height-pointerViewH)/2;
        _pointerView.frame=CGRectMake(pointerViewX, pointerViewY, pointerViewW, pointerViewH);
        _rulerView.frame=CGRectMake(0,self.frame.size.height/2, self.frame.size.width, rulerViewWOH);
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取每个表格的长度
    UIImage *ruleImage=[UIImage imageNamed:@"ruler_weight"];
    
    CGFloat formlength=ruleImage.size.width/(CGFloat)_rulerMultiple;
    //指针指向的刻度
    CGFloat value=0;
    //滑动的刻度值
    CGFloat scrollValue=0;
    
    if ([self.delegate respondsToSelector:@selector(getRulerValue:withScrollRulerView:)]) {
        CGFloat contentOffsetValue=0;
        if (_showType==rulerViewshowHorizontalType) {
            contentOffsetValue=scrollView.contentOffset.x;
        }else{
              contentOffsetValue=scrollView.contentOffset.y;
        }
        scrollValue=(contentOffsetValue/formlength)-((CGFloat)_rulerMultiple/2);
        
        if (_round) {
            value=_mixNuber+round(scrollValue);
        }else{
            value=_mixNuber+scrollValue;
        }
        
        [self.delegate getRulerValue:value withScrollRulerView:self];
    }
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view=[super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[ZHRulerView class]]) {
        return _rulerView;
    }else{
        return view;
    }
}

@end
