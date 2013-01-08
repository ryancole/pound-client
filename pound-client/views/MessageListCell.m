//
//  MessageListCell.m
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "MessageListCell.h"

#define LEFT_RIGHT_MARGIN 10.0
#define TOP_BOTTOM_MARGIN 10.0
#define LABEL_LINE_HEIGHT 15.0

@interface MessageListCell () <OHAttributedLabelDelegate>

@end

@implementation MessageListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        // source label
        _source = [[UILabel alloc] init];
        _source.font = [UIFont boldSystemFontOfSize:12];
        _source.backgroundColor = [UIColor clearColor];
        
        // timestamp label
        _timestamp = [[UILabel alloc] init];
        _timestamp.font = [UIFont systemFontOfSize:12];
        _timestamp.textAlignment = NSTextAlignmentRight;
        _timestamp.textColor = [UIColor blueColor];
        _timestamp.backgroundColor = [UIColor clearColor];
        
        // message label
        _message = [[OHAttributedLabel alloc] init];
        _message.font = [UIFont systemFontOfSize:12];
        _message.numberOfLines = 0;
        _message.lineBreakMode = NSLineBreakByWordWrapping;
        _message.backgroundColor = [UIColor clearColor];
        _message.delegate = self;
        
        // add the labels to the cell
        [self.contentView addSubview:_source];
        [self.contentView addSubview:_message];
        [self.contentView addSubview:_timestamp];
        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // half of the cell's content view width
    CGFloat halfCellWidth = self.contentView.frame.size.width / 2;
    
    // the dimensions of the message label, primarily for the height
    CGSize mesageLabelDimensions = [_message.text sizeWithFont:[UIFont systemFontOfSize:12]
                                             constrainedToSize:CGSizeMake(self.contentView.frame.size.width - (LEFT_RIGHT_MARGIN * 2), CGFLOAT_MAX)];
    
    // adjust the frames of the cell labels
    _source.frame = CGRectMake(LEFT_RIGHT_MARGIN, TOP_BOTTOM_MARGIN, halfCellWidth - LEFT_RIGHT_MARGIN, LABEL_LINE_HEIGHT);
    _timestamp.frame = CGRectMake(halfCellWidth, TOP_BOTTOM_MARGIN, halfCellWidth - LEFT_RIGHT_MARGIN, LABEL_LINE_HEIGHT);
    _message.frame = CGRectMake(LEFT_RIGHT_MARGIN, LABEL_LINE_HEIGHT + (TOP_BOTTOM_MARGIN * 2), mesageLabelDimensions.width, mesageLabelDimensions.height);
    
}

#pragma mark - Custom Functions

- (CGFloat)getCalculatedCellHeight {
    
    // the dimensions of the message label, primarily for the height
    CGSize mesageLabelDimensions = [_message.text sizeWithFont:[UIFont systemFontOfSize:12]
                                             constrainedToSize:CGSizeMake(self.contentView.frame.size.width - (LEFT_RIGHT_MARGIN * 2), CGFLOAT_MAX)];
    
    // the total height of all combined labels that affect height, plus margins
    return mesageLabelDimensions.height + LABEL_LINE_HEIGHT + (TOP_BOTTOM_MARGIN * 4);
    
}

#pragma mark - OHAttributedLabel

-(BOOL)attributedLabel:(OHAttributedLabel*)attributedLabel shouldFollowLink:(NSTextCheckingResult*)linkInfo {
    
    return YES;
    
}

@end
