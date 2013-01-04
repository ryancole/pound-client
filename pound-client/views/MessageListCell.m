//
//  MessageListCell.m
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "MessageListCell.h"
#import "ContentModeLabel.h"

#define LEFT_RIGHT_MARGIN 10.0
#define TOP_BOTTOM_MARGIN 10.0
#define LABEL_LINE_HEIGHT 20.0

@implementation MessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // intiialize the cell
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // source label
        _source = [[ContentModeLabel alloc] initWithFrame:CGRectMake(LEFT_RIGHT_MARGIN,
                                                                     TOP_BOTTOM_MARGIN,
                                                                     140.0,
                                                                     LABEL_LINE_HEIGHT)];

        _source.font = [UIFont boldSystemFontOfSize:12];
        _source.contentMode = UIViewContentModeTop;
        
        // timestamp label
        _timestamp = [[ContentModeLabel alloc] initWithFrame:CGRectMake(140.0 + LEFT_RIGHT_MARGIN,
                                                                        TOP_BOTTOM_MARGIN,
                                                                        140.0,
                                                                        LABEL_LINE_HEIGHT)];
        
        _timestamp.font = [UIFont italicSystemFontOfSize:12];
        _timestamp.textAlignment = NSTextAlignmentRight;
        _timestamp.contentMode = UIViewContentModeTop;
        
        // message label
        _message = [[ContentModeLabel alloc] initWithFrame:CGRectMake(LEFT_RIGHT_MARGIN,
                                                                      LABEL_LINE_HEIGHT * 2.0,
                                                                      280.0,
                                                                      LABEL_LINE_HEIGHT)];
        
        _message.numberOfLines = 0;
        _message.contentMode = UIViewContentModeTop;
        _message.font = [UIFont systemFontOfSize:12];
        
        // add the labels to the cell
        [self.contentView addSubview:_source];
        [self.contentView addSubview:_message];
        [self.contentView addSubview:_timestamp];
        
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

- (void)adjustHeights {
    
    // calculate the needed height
    CGSize size = [_message.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(280.0, 500.0)];
    
    // adjust the frame for this height
    _message.frame = CGRectMake(_message.frame.origin.x, _message.frame.origin.y, _message.frame.size.width, size.height);
    
}

@end
