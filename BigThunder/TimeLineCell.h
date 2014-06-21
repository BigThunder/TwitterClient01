//
//  TimeLineCell.h
//  BigThunder
//
//  Created by 大山田 圭吾 on 2014/06/14.
//  Copyright (c) 2014年 Keigo Oyamada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineCell : UITableViewCell

@property(nonatomic,strong) UILabel *tweetTextLabel;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UIImageView *profileImageView;
@property(nonatomic) float tweetTextLabelHeight;

@end
