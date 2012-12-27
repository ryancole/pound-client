//
//  MessageListCell.h
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *source;
@property (nonatomic, strong) IBOutlet UILabel *message;
@property (nonatomic, strong) IBOutlet UILabel *destination;
@property (nonatomic, strong) IBOutlet UILabel *timestamp;

@end
