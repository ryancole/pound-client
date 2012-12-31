//
//  ChannelListCell.m
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ChannelListCell.h"
#import "ContentModeLabel.h"

@implementation ChannelListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // intiialize the cell
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        // channel label
        _name = [[ContentModeLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        // add the labels to the cell
        [self.contentView addSubview:_name];
        
    }
    
    // return the custom cell
    return self;
}

#pragma mark - Custom Functions

- (CGFloat)getCalculatedCellHeight {
    
    return _name.frame.size.height;
    
}

@end
