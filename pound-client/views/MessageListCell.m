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
    // intiialize the cell
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
        // source label
        _source = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 25)];
        _source.font = [UIFont boldSystemFontOfSize:10];
        [self.contentView addSubview:_source];
        
        // message label
        _message = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.frame.size.width - 20, 50)];
        _message.font = [UIFont systemFontOfSize:12];
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

@end
