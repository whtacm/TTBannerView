//
//  ViewController.m
//  TTBannerViewDemo
//
//  Created by Haitao-Wong on 8/29/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//

#import "ViewController.h"

#import "TTBannerView.h"

@interface ViewController () <TTBannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"TTBanner";
    
    //
    NSArray<NSString*>* localImgArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    
    NSArray<NSString*>* titleArray1 = @[@"南京列入中国文化名城 金陵四大好景推荐",
                                        @"环游世界：越惊险越美丽 奇特火山美景",
                                        @"震后三年 四条线路带你看尽成都美景",
                                        @"从西安出发 11月一睹秋末最压轴美景"];
    
    TTBannerView *ttbv1 = [[TTBannerView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200) type:TitleCentralAlign localImgArray:localImgArray titleArray:titleArray1 pageIndicatorTintColor:[UIColor whiteColor] currentPageIndicatorTintColor:[UIColor greenColor] timerInterval:2.0f delegate:self];
    
    [self.view addSubview:ttbv1];
    
    
    
    
    //
    NSArray *imgURLArray = @[@"http://5.66825.com/download/pic/000/326/77066009f039bb215b3ab09c9297356a.jpg",
                             @"http://i1.download.fd.pchome.net/t_960x600/g1/M00/09/17/ooYBAFO-BwWIW4pnAAHU7t-Cj6gAABu2wKKJkAAAdUG122.jpg",
                             @"http://newpaper.dahe.cn/hnrb/images/2012-10/30/05/hnrb20121030b005cb008.jpg",
                             @"http://img1.3lian.com/img013/v2/63/d/1.jpg"];
    
    NSArray<NSString*>* titleArray2= @[@"野外夕阳美景摄影图片",
                                       @"超高清海岸美景电脑桌面壁纸",
                                       @"10月27日，壮乡广西河池市东兰县武篆镇秋色迷人",
                                       @"夕阳下的美景图片"];
    
    
    TTBannerView *ttbv2 = [[TTBannerView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200) type:TitleLeftAlign imgURLArray:imgURLArray placeholderImage:nil titleArray:titleArray2 pageIndicatorTintColor:[UIColor whiteColor] currentPageIndicatorTintColor:[UIColor grayColor] timerInterval:3.0f click:^(NSInteger imgIndex) {
        NSLog(@"you click: %ld",(long)imgIndex);
    }];
    
    [self.view addSubview:ttbv2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onClick:(NSInteger)imgIndex{
    NSLog(@"you click: %ld",(long)imgIndex);
}

@end
