//
//  ChannelListCell.m
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ChannelListCell.h"

#define LEFT_RIGHT_MARGIN 10.0
#define TOP_BOTTOM_MARGIN 10.0
#define LABEL_LINE_HEIGHT 20.0

@implementation ChannelListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        // channel label
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:12];
        _name.backgroundColor = [UIColor clearColor];
        
        // add the labels to the cell
        [self.contentView addSubview:_name];
        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // adjust the frames of the cell labels
    _name.frame = CGRectMake(LEFT_RIGHT_MARGIN, TOP_BOTTOM_MARGIN, self.contentView.frame.size.width - (LEFT_RIGHT_MARGIN * 2), LABEL_LINE_HEIGHT);
    
}

@end
