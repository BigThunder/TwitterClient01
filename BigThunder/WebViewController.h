//
//  WebViewController.h
//  BigThunder
//
//  Created by 大山田 圭吾 on 2014/06/21.
//  Copyright (c) 2014年 Keigo Oyamada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,strong) NSURL *openURL;

@end
