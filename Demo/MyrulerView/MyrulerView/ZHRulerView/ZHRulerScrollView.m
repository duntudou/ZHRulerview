//
//  ZHRulerScrollView.m
//  MyrulerView
//
//  Created by mac on 15-1-5.
//  Copyright (c) 2015年 zhz. All rights reserved.
//

#import "ZHRulerScrollView.h"


#define BTminus(maxNuber,mixNuber)  ABS((maxNuber-mixNuber))
#define ZHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


//判断ScrollView是否水平显示
//#define isHorizontal (self.frame.size.width>self.frame.size.height)

//刻度距离文字的距离
static const CGFloat imageSpaceToLable=10;

//显示刻度的lable的字体大小
static const CGFloat rulerLableFont=12;
@interface ZHRulerScrollView ()

@property(nonatomic,strong)UIImage *rulerImage;

@property(nonatomic,assign)NSInteger mixNuber;
@property(nonatomic,assign)NSInteger maxNuber;
@property(nonatomic,assign)rulerViewShowType showType;
@property(nonatomic,assign)NSInteger rulerMultiple;
@end

@implementation ZHRulerScrollView

-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(rulerViewShowType)showType rulerMultiple:(NSInteger)rulerMultiple{
    
    self=[super init];
    if (self) {
        _mixNuber=mixNuber;
        _maxNuber=maxNuber;
        _showType=showType;
        _rulerMultiple=rulerMultiple;
        
        [self setCanCancelContentTouches:NO];
        self.backgroundColor=[UIColor clearColor];
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator=NO;
        self.bounces=YES;
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        self.decelerationRate=0.7;
        self.clipsToBounds=NO;
        if (_showType==rulerViewshowHorizontalType) {//如果水平放置
            _rulerImage=[UIImage imageNamed:@"ruler_weight"];
            self.contentSize=CGSizeMake(_rulerImage.size.width*( BTminus(_maxNuber, _mixNuber)/rulerMultiple+1), self.frame.size.height);
        }else{
            _rulerImage=[UIImage imageNamed:@"ruler_height"];
            self.contentSize=CGSizeMake(self.frame.size.width, _rulerImage.size.height*(BTminus(_maxNuber, _mixNuber)/rulerMultiple+1));
        }
        //添加显示刻度ImageView
        [self setUpRuleImageView];
        
    }
    return self;
}

-(void)setUpRuleImageView{
    
    for (NSInteger i=0; i<=BTminus(_maxNuber,_mixNuber)/_rulerMultiple ; i++) {
        UIImageView *rulerImageView=[[UIImageView alloc] initWithImage:_rulerImage];
        rulerImageView.tag=i;
        [self addSubview:rulerImageView];
        UILabel *rulerLable=[[UILabel alloc] init];
        rulerLable.textAlignment=NSTextAlignmentCenter;
        rulerLable.text=[NSString stringWithFormat:@"%zd",_mixNuber+i*_rulerMultiple];
        rulerLable.textColor=ZHColor(204, 204, 204);
        rulerLable.font=[UIFont systemFontOfSize:rulerLableFont];
        [self addSubview:rulerLable];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (UIView *sub in self.subviews) {
        CGPoint centerPoint;
        CGFloat rulerImageViewW;
        CGFloat rulerImageViewH;
        if ([sub isKindOfClass:[UIImageView class]]) {
            rulerImageViewW=sub.frame.size.width;
            rulerImageViewH=sub.frame.size.height;
            CGFloat rulerImageViewX=(_showType==rulerViewshowHorizontalType)?rulerImageViewW*sub.tag:0;
            CGFloat rulerImageViewY=(_showType==rulerViewshowHorizontalType)?0:rulerImageViewH*sub.tag;
            sub.frame=CGRectMake(rulerImageViewX, rulerImageViewY, rulerImageViewW,rulerImageViewH);
            centerPoint=sub.center;
        }else if ([sub isKindOfClass:[UILabel class]]){
            CGFloat rulerLableX;
            CGFloat rulerLableY;
            CGFloat rulerLableW;
            CGFloat rulerLableH;
            
            if (_showType==rulerViewshowHorizontalType) {
                rulerLableW=60;
                rulerLableH=20;
                rulerLableX =centerPoint.x-rulerLableW/2;
                rulerLableY=rulerImageViewH+imageSpaceToLable;
            }else{
                rulerLableW=60;
                rulerLableH=60;
                rulerLableX=rulerImageViewW-imageSpaceToLable;
                rulerLableY=centerPoint.y-rulerLableH/2;
            }
            sub.frame=CGRectMake(rulerLableX, rulerLableY, rulerLableW, rulerLableH);
        }
    }
}

@end
