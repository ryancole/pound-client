//
//  MessageListCell.m
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
