//
//  TTBannerView.m
//  TTBannerViewDemo
//
//  Created by Haitao-Wong on 8/29/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//

#import "TTBannerView.h"

@interface TTBannerView ()<UIScrollViewDelegate>

@property (nonatomic) TTBannerViewType type;

@property (nonatomic, weak) id<TTBannerViewDelegate> delegate;

@property (nonatomic, copy) TTClickBlock clickBlock;

@property (nonatomic, strong) NSArray<NSString*> *titleArray;

@property (nonatomic, strong) NSArray<NSString*> *imgURLArray;

@property (nonatomic, strong) NSArray<NSString*> *localImgArray;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy  ) NSString *placeholderImage;

@property (nonatomic, assign) CGFloat timerInterval;

@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak  ) UIView *rootView;

@property (nonatomic, weak  ) UIScrollView *scrollView;

@property (nonatomic, weak  ) UIPageControl *pageControl;

@property (nonatomic, weak  ) UILabel *titleLabel;
@end

@implementation TTBannerView


-(instancetype)initWithFrame:(CGRect)frame
                        type:(TTBannerViewType)type
               localImgArray:(NSArray<NSString*>  *)localImgArray
                  titleArray:(NSArray<NSString*>  *)titleArray
      pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
               timerInterval:(NSInteger)timeInterval
                       click:(TTClickBlock)click{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.localImgArray = localImgArray;
        self.titleArray = titleArray;
        self.count = self.localImgArray.count;
        
        self.timerInterval = timeInterval;
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        self.pageIndicatorTintColor = pageIndicatorTintColor;
        
        self.clickBlock = click;
        
        [self setupView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
                        type:(TTBannerViewType)type
               localImgArray:(NSArray<NSString*>  *)localImgArray
                  titleArray:(NSArray<NSString*>  *)titleArray
      pageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor
               timerInterval:(NSInteger)timeInterval
                    delegate:(id<TTBannerViewDelegate>)delegate{
    
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.localImgArray = localImgArray;
        self.titleArray = titleArray;
        self.count = self.localImgArray.count;
        
        self.timerInterval = timeInterval;
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        self.pageIndicatorTintColor = pageIndicatorTintColor;
        
        self.delegate = delegate;
        
        [self setupView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
                        type:(TTBannerViewType)type
                 imgURLArray:(NSArray<NSString*>  *)imgURLArray
            placeholderImage:(NSString *)placeholderImage
                  titleArray:(NSArray<NSString*>  *)titleArray
      pageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor
               timerInterval:(NSInteger)timeInterval
                       click:(TTClickBlock)click{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.imgURLArray = imgURLArray;
        self.titleArray = titleArray;
        self.placeholderImage = placeholderImage;
        self.count = self.imgURLArray.count;
        
        self.timerInterval = timeInterval;
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        self.pageIndicatorTintColor = pageIndicatorTintColor;
        self.placeholderImage = placeholderImage;
        
        self.clickBlock = click;
        
        [self setupView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
                        type:(TTBannerViewType)type
                 imgURLArray:(NSArray<NSString*>  *)imgURLArray
            placeholderImage:(NSString *)placeholderImage
                  titleArray:(NSArray<NSString*>  *)titleArray
      pageIndicatorTintColor:(UIColor*)pageIndicatorTintColor
currentPageIndicatorTintColor:(UIColor*)currentPageIndicatorTintColor
               timerInterval:(NSInteger)timeInterval
                    delegate:(id<TTBannerViewDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.imgURLArray = imgURLArray;
        self.titleArray = titleArray;
        self.placeholderImage = placeholderImage;
        self.count = self.imgURLArray.count;
        
        self.timerInterval = timeInterval;
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
        self.pageIndicatorTintColor = pageIndicatorTintColor;
        self.placeholderImage = placeholderImage;
        
        self.delegate = delegate;
        
        [self setupView];
    }
    
    return self;
}

-(void)setupView{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    [self addSubview:(
                      {
                          self.rootView = view;
                      })
     ];
    
    [self addSubview:({
        UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        
        for (int i = 0; i < self.count + 2; i++) {
            UIImageView *imgView = [[UIImageView alloc]init];
            NSInteger tag = 0;
            
            if (i == 0) {
                tag = self.count - 1;
            }else if(i == self.count + 1 ){
                tag = 0;
            }else{
                tag = i - 1;
            }
            
            if (self.localImgArray) {
                imgView.image = [UIImage imageNamed:self.localImgArray[tag]];
            }else{
                [imgView sd_setImageWithURL:[NSURL URLWithString:self.imgURLArray[tag]] placeholderImage:[UIImage imageNamed:self.placeholderImage]];
            }
            
            imgView.tag = tag;
            imgView.clipsToBounds = YES;
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.frame = CGRectMake(width * i, 0, width, height);

            [sv addSubview:imgView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgSingleTap:)];
            [imgView addGestureRecognizer:tap];
        }
        
        sv.delegate = self;
        sv.scrollsToTop = NO;
        sv.pagingEnabled = YES;
        sv.showsHorizontalScrollIndicator = NO;
        sv.backgroundColor = [UIColor grayColor];
        sv.contentOffset = CGPointMake(width, 0);
        sv.contentSize = CGSizeMake(width * (self.count + 2), 0);
        
        self.scrollView = sv;
    })];
    
    
    
    if (self.type == TitleLeftAlign ||
        self.type == TitleCentralAlign ||
        self.type == TitleRightAlign) {
        [self addSubview:({
            UILabel *titleLabel  =[[UILabel alloc]initWithFrame:CGRectMake(10, height - 40, width - 20, 26)];
            [titleLabel setTextColor:[UIColor whiteColor]];
            [titleLabel setFont:[UIFont systemFontOfSize:15]];
            switch (self.type) {
                case TitleLeftAlign:
                    [titleLabel setTextAlignment:NSTextAlignmentLeft];
                    break;
                case TitleCentralAlign:
                    [titleLabel setTextAlignment:NSTextAlignmentCenter];
                    break;
                default:
                    [titleLabel setTextAlignment:NSTextAlignmentRight];
                    break;
            }
            [titleLabel setText:self.titleArray[0]];
            self.titleLabel = titleLabel;
            //   [self addSubview:self.titleLabel];
        })];
        
    }
    
    [self addTimer];
    
    if (self.type != OnlyPic) {
        [self addSubview:({
            UIPageControl *pc=  [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - 24, width, 24)];
            
            pc.tintColor = [UIColor clearColor];
            pc.backgroundColor = [UIColor clearColor];
            pc.numberOfPages = self.count ;
            pc.userInteractionEnabled = NO;
            pc.pageIndicatorTintColor = self.pageIndicatorTintColor ? self.pageIndicatorTintColor : [UIColor whiteColor];
            pc.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor ? self.currentPageIndicatorTintColor : [UIColor grayColor];
            
            self.pageControl = pc;
        })];
        
    }
}

-(void) addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(nextImg) userInfo:nil repeats:YES ];
    [[NSRunLoop currentRunLoop ]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)nextImg{
    NSInteger curPage = self.pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake((curPage + 2) * self.scrollView.frame.size.width, 0)
                             animated:YES];
}

-(void) removeTimer{
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
    }
    
}


- (void)imgSingleTap:(UITapGestureRecognizer *)tap {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(onClick:)]) {
            
            [self.delegate onClick:tap.view.tag];
        }
    }
    
    if (self.clickBlock) {
        self.clickBlock(tap.view.tag);
    }
    
}
#pragma 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat offx = scrollView.contentOffset.x;
    NSInteger curPage = offx / width;
    
    if (curPage == 0 ) {
        
        self.pageControl.currentPage = self.count;
        
    }else if(curPage == self.count + 1){
        
        self.pageControl.currentPage = 0;
        
    }else{
        
        self.pageControl.currentPage = curPage - 1;
        
    }
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat offx = scrollView.contentOffset.x;
    NSInteger curPage = offx / width;
    
    if (curPage == 0 ) {
        
        [self.titleLabel setText:self.titleArray[self.count-1]];
        self.pageControl.currentPage = self.count;
        [self.scrollView setContentOffset:CGPointMake(self.count * width, 0) animated:NO];
        
    }else if(curPage == self.count + 1){
        
        [self.titleLabel setText:self.titleArray[0]];
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        
    }else{
        
        [self.titleLabel setText:self.titleArray[curPage - 1]];
        self.pageControl.currentPage = curPage - 1;
        
    }
    
}

/**
 *
 *
 *  @param scrollView
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self removeTimer];
}

/**
 *
 *
 *  @param scrollView
 *  @param decelerate   	
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
@end
