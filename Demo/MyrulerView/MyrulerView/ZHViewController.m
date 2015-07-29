//
//  ZHViewController.m
//  MyRulerView
//
//  Created by mac on 15-1-5.
//  Copyright (c) 2015年 zhz. All rights reserved.
//

#import "ZHViewController.h"
#import "ZHRulerView.h"

static CGFloat const rulerMultiple=10;
@interface ZHViewController ()<ZHRulerViewDelegate>


@property(nonatomic,strong)ZHRulerView *rulerview;
@property(nonatomic,strong)UILabel *valueLable;
@end
@implementation ZHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect1=CGRectMake(20, 200, self.view.frame.size.width-40, 45);
    ZHRulerView *rulerview=[[ZHRulerView alloc]initWithMixNuber:80 maxNuber:1000 showType:rulerViewshowHorizontalType rulerMultiple:rulerMultiple];
    rulerview.defaultVaule=83;
    rulerview.frame=rect1;
    _rulerview=rulerview;
    _rulerview.delegate=self;
    [self.view  addSubview:rulerview];
    UIButton *statusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    statusBtn.backgroundColor=[UIColor redColor];
    statusBtn.frame=CGRectMake(self.view.frame.size.width-80, 60, 40, 40);
    [statusBtn setTitle:@"垂直" forState:UIControlStateNormal];
    [statusBtn setTitle:@"水平" forState:UIControlStateSelected];
    [statusBtn addTarget:self action:@selector(changeRulerShowType:) forControlEvents:UIControlEventTouchUpInside];
     [self.view  addSubview:statusBtn];
    
    UILabel *valueLable=[[UILabel alloc] init];
    _valueLable=valueLable;
    valueLable.font=[UIFont systemFontOfSize:18];
    valueLable.frame=CGRectMake(20, 60, 150, 80);
    valueLable.textColor=[UIColor blackColor];
    valueLable.text=@"0";
    [self.view  addSubview:valueLable];
}
-(void)changeRulerShowType:(UIButton *)button{
    button.selected=!button.selected;
    [_rulerview removeFromSuperview];
    CGRect rect1=CGRectMake(20,200, self.view.frame.size.width-40, 50);
    CGRect rect2=CGRectMake(150, 50, 50, self.view.frame.size.height-100);
    if ( button.selected) {
        _rulerview= [[ZHRulerView alloc]initWithMixNuber:80 maxNuber:1000 showType:rulerViewshowVerticalType rulerMultiple:rulerMultiple];
        _rulerview.frame=rect2;
    }else{
        [_rulerview removeFromSuperview];
        _rulerview=[[ZHRulerView alloc]initWithMixNuber:80 maxNuber:1000 showType:rulerViewshowHorizontalType rulerMultiple:rulerMultiple];
        _rulerview.frame=rect1;
    }
    //代理方法返回一个小数四舍五入的数值
//    _rulerview.round=YES;
    _rulerview.delegate=self;
    _rulerview.defaultVaule=85;
//    _rulerview.backgroundColor=[UIColor yellowColor];
    [self.view  addSubview:_rulerview];
    
}

#pragma mark rulerviewDelagete
-(void)getRulerValue:(CGFloat)rulerValue withScrollRulerView:(ZHRulerView *)rulerView{
    _valueLable.text=[NSString stringWithFormat:@"%f",rulerValue];
    NSLog(@"rulerValue %f",rulerValue);
}

@end
