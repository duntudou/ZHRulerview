//
//  ZHRulerView.h
//  MyrulerView
//
//  Created by mac on 15-1-5.
//  Copyright (c) 2015年 zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHRulerScrollView.h"

@class ZHRulerView;

@protocol ZHRulerViewDelegate <NSObject>

@optional
-(void)getRulerValue:(CGFloat)rulerValue withScrollRulerView:(ZHRulerView *)rulerView;

@end

@interface ZHRulerView : UIView


@property(nonatomic,weak)ZHRulerScrollView *rulerView;
/**
 *  是否对小数四舍五入
 */
@property(nonatomic,assign)BOOL round;
/**
 *  刻度默认值
 */
@property(nonatomic,assign) CGFloat defaultVaule;
@property(nonatomic,weak) id<ZHRulerViewDelegate> delegate;

/**
 *  创建一个rulerView
 *
 *  @param mixNuber 最小刻度
 *  @param maxNuber 最大刻度
 *  @param showType 显示模式
 *  @param rulerMultiple 刻度的倍数
 *  @return rulerView
 */
-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(rulerViewShowType)showType rulerMultiple:(NSInteger)rulerMultiple;
@end
