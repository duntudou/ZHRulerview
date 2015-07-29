//
//  ZHRulerScrollView.h
//  MyrulerView
//
//  Created by mac on 15-1-5.
//  Copyright (c) 2015年 zhz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, rulerViewShowType) {
    /**
     *  水平显示模式
     */
    rulerViewshowHorizontalType=0,
    /**
     *  垂直显示模式
     */
    rulerViewshowVerticalType
};


@interface ZHRulerScrollView : UIScrollView

-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(rulerViewShowType)showType rulerMultiple:(NSInteger)rulerMultiple;


@end
