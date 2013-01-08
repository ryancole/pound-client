//
//  JoinChannelCell.m
//  pound-client
//
//  Created by Ryan Cole on 1/6/13.
//  Copyright (c) 2013 Ryan Cole. All rights reserved.
//

#import "JoinChannelCell.h"

#define LEFT_RIGHT_MARGIN 10.0
#define TOP_BOTTOM_MARGIN 10.0
#define LABEL_LINE_HEIGHT 20.0

@interface JoinChannelCell ()

@property (nonatomic, strong) UILabel *prefixLabel;

@end

@implementation JoinChannelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        _prefixLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _prefixLabel.font = [UIFont systemFontOfSize:12];
        _prefixLabel.textColor = [UIColor grayColor];
        _prefixLabel.text = @"Channel:";
        
        _channelName = [[UITextField alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:_prefixLabel];
        [self.contentView addSubview:_channelName];
        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _prefixLabel.frame = CGRectMake(LEFT_RIGHT_MARGIN, TOP_BOTTOM_MARGIN, 60, LABEL_LINE_HEIGHT);
    _channelName.frame = CGRectMake(LEFT_RIGHT_MARGIN + 60, TOP_BOTTOM_MARGIN, self.contentView.frame.size.width - ((LEFT_RIGHT_MARGIN * 2) + 60), LABEL_LINE_HEIGHT);
    
}

@end
