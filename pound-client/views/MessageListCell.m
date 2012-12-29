//
//  MessageListCell.m
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "MessageListCell.h"
#import "../utilities/ContentModeLabel.h"

@implementation MessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // intiialize the cell
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        // source label
        _source = [[ContentModeLabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 40, 20)];
        _source.contentMode = UIViewContentModeTop;
        _source.font = [UIFont boldSystemFontOfSize:12];
        
        // message label
        _message = [[ContentModeLabel alloc] initWithFrame:CGRectMake(10, 35, self.frame.size.width - 40, 30)];
        _message.numberOfLines = 0;
        _message.contentMode = UIViewContentModeTop;
        _message.font = [UIFont systemFontOfSize:12];
        
        // add the labels to the cell
        [self.contentView addSubview:_source];
        [self.contentView addSubview:_message];
        
    }
    
    // return the custom cell
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Custom Functions

- (CGFloat)getCalculatedCellHeight {
    
    return _message.frame.size.height + _source.frame.size.height + 30;
    
}

@end
