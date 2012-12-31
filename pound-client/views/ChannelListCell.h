//
//  ChannelListCell.h
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelListCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *name;

- (CGFloat)getCalculatedCellHeight;

@end
