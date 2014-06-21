//
//  ViewController.m
//  BigThunder
//
//  Created by 大山田 圭吾 on 2014/06/14.
//  Copyright (c) 2014年 Keigo Oyamada. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *accountDisplayLabel;

@property(nonatomic,strong) ACAccountStore *accountStore;
@property(nonatomic,copy) NSArray *twitterAccounts;
@property(nonatomic,copy) NSString *identifier;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:twitterType options:NULL completion:^(BOOL granted, NSError *error) {
        if(granted){
            self.twitterAccounts =[self.accountStore accountsWithAccountType:twitterType];
            if(self.twitterAccounts.count > 0){
                ACAccount *account = self.twitterAccounts[0];
                self.identifier = account.identifier;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.accountDisplayLabel.text = account.username;}
                           );
            }else{dispatch_async(dispatch_get_main_queue(), ^{
                self.accountDisplayLabel.text = @"no user";}
            );}
        }else{
            NSLog(@"Account Error: %@", [error localizedDescription]);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.accountDisplayLabel.text = @"Account Authorization error";
            });
        }
        }
     ];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweet:(id)sender {
    // 最小限のTweetコード
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) { //利用可能チェック
        NSString *serviceType = SLServiceTypeTwitter;
        SLComposeViewController *composeCtl =
        [SLComposeViewController composeViewControllerForServiceType:serviceType];
        [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultDone) { //投稿成功時の処理
            NSLog(@"Tweet completed");
        } }];
        [self presentViewController:composeCtl animated:YES completion:nil];
}
}

- (IBAction)setAccountAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]init];
    sheet.delegate = self;
    sheet.title = @"please choose";
    for(ACAccount *account in self.twitterAccounts){
        [sheet addButtonWithTitle:account.username];
    }
    [sheet addButtonWithTitle:@"Cancel"];
    sheet.cancelButtonIndex = self.twitterAccounts.count;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(self.twitterAccounts.count > 0){
        if (buttonIndex != self.twitterAccounts.count) {
            ACAccount *account = self.twitterAccounts[buttonIndex];
            self.identifier = account.identifier;
            self.accountDisplayLabel.text = account.username;
            NSLog(@"Set Account! %@", account.username);
        }else{
            NSLog(@"Cancel!");
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"timeLineSegue"]){
        TimeLineTableViewController *timeLineVC = segue.destinationViewController;
        if([timeLineVC isKindOfClass:[TimeLineTableViewController class]]){
            timeLineVC.identifier = self.identifier;
        }
    }

}

@end
