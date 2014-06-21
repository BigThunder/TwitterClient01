//
//  MyUIApplication.m
//  BigThunder
//
//  Created by 大山田 圭吾 on 2014/06/21.
//  Copyright (c) 2014年 Keigo Oyamada. All rights reserved.
//

#import "MyUIApplication.h"
#import "AppDelegate.h"
#import "WebViewController.h"

@implementation MyUIApplication

-(BOOL)openURL:(NSURL *)url
{
    if(!url){
        return NO;
    }
    self.myOpenURL = url;
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.openURL = self.myOpenURL;
    webViewController.title = @"Web View";
    [appDelegate.navigationController pushViewController:webViewController animated:YES];
    self.myOpenURL = nil;
    return YES;
}
@end
