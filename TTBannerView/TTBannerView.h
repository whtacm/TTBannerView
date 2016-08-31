//
//  TTBannerView.h
//  TTBannerViewDemo
//
//  Created by Haitao-Wong on 8/29/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@class TTBannerView;

/**
 * TTBannerView types
 */
typedef NS_ENUM(NSInteger,TTBannerViewType) {
    /**
     * 只显示滚动图片
     */
    OnlyPic,
    /**
     *  显示滚动图片的分页控件，不添加标题
     */
    Normal,
    /**
     * 分页控件和标题都显示，标题居中
     */
    TitleCentralAlign,
    /**
     * 分页控件和标题都显示，标题居左
     */
    TitleLeftAlign,
    /**
     * 分页控件和标题都显示，标题居右
     */
    TitleRightAlign
};

/**
 * 点击滚动图片的调用的block
 *
 *  @param 点击的图片的下标
 */
typedef void(^TTClickBlock)(NSInteger imgIndex) ;


#pragma delegate
/**
 *
 */
@protocol TTBannerViewDelegate <NSObject>

@optional

/**
 *
 *
 *  @param imgIndex
 */
-(void) onClick:(NSInteger) imgIndex;

@end



#pragma
@interface TTBannerView : UIView


/**
 *
 *
 *  @param frame 滚动栏的frame
 *  @param type 滚动栏的类型
 *  @param localImgArray 本地图片array
 *  @param titleArray 标题array
 *  @param pageIndicatorTintColor 分页控件指示的颜色，默认白色
 *  @param currentPageIndicatorTintColor 当前分页控件指示的颜色，默认灰色
 *  @param timeInterval 滚动时间间隔
 *  @param click 点击block
 *
 *  @return
 */
-(instancetype) initWithFrame:(CGRect)frame
                         type:(TTBannerViewType)type
                localImgArray:(NSArray<NSString*> *)localImgArray
                   titleArray:(NSArray<NSString*> *)titleArray
       pageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor
                timerInterval:(NSInteger)timeInterval
                        click:(TTClickBlock)click;

/**
 *
 *
 *  @param frame 滚动栏的frame
 *  @param type 滚动栏的类型
 *  @param localImgArray 本地图片array
 *  @param titleArray 标题array
 *  @param pageIndicatorTintColor 分页控件指示的颜色，默认白色
 *  @param currentPageIndicatorTintColor 当前分页控件指示的颜色，默认灰色
 *  @param timeInterval 滚动时间间隔
 *  @param delegate 点击的代理
 *
 *  @return 
 */
-(instancetype) initWithFrame:(CGRect)frame
                         type:(TTBannerViewType)type
                localImgArray:(NSArray<NSString*> *)localImgArray
                   titleArray:(NSArray<NSString*> *)titleArray
       pageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor
                timerInterval:(NSInteger)timeInterval
                     delegate:(id<TTBannerViewDelegate>)delegate;

/**
 *
 *
 *  @param frame 滚动栏的frame
 *  @param type 滚动栏的类型
 *  @param imgURLArray 网络图片URL array
 *  @param placeholderImage
 *  @param titleArray 标题array
 *  @param pageIndicatorTintColor 分页控件指示的颜色，默认白色
 *  @param currentPageIndicatorTintColor 当前分页控件指示的颜色，默认灰色
 *  @param timeInterval 滚动时间间隔
 *  @param click 点击block
 *
 *  @return
 */
-(instancetype) initWithFrame:(CGRect)frame
                         type:(TTBannerViewType)type
                  imgURLArray:(NSArray<NSString*> *)imgURLArray
             placeholderImage:(NSString *)placeholderImage
                   titleArray:(NSArray<NSString*> *)titleArray
       pageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor
                timerInterval:(NSInteger)timeInterval
                        click:(TTClickBlock)click;

/**
 *
 *
 *  @param frame 滚动栏的frame
 *  @param type 滚动栏的类型
 *  @param imgURLArray 网络图片URL array
 *  @param placeholderImage
 *  @param titleArray 标题array
 *  @param pageIndicatorTintColor 分页控件指示的颜色，默认白色
 *  @param currentPageIndicatorTintColor 当前分页控件指示的颜色，默认灰色
 *  @param timeInterval 滚动时间间隔
 *  @param delegate 点击的代理
 *
 *  @return
 */
-(instancetype) initWithFrame:(CGRect)frame
                         type:(TTBannerViewType)type
                  imgURLArray:(NSArray<NSString*> *)imgURLArray
             placeholderImage:(NSString *)placeholderImage
                   titleArray:(NSArray<NSString*> *)titleArray
       pageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor
                timerInterval:(NSInteger)timeInterval
                     delegate:(id<TTBannerViewDelegate>)delegate;




@end
