//
//  MessageListCell.h
//  pound-client
//
//  Created by Ryan Cole on 12/27/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Pods/OHAttributedLabel/OHAttributedLabel/Source/OHAttributedLabel.h"

@interface MessageListCell : UITableViewCell

@property (nonatomic, strong) UILabel *source;
@property (nonatomic, strong) UILabel *timestamp;
@property (nonatomic, strong) OHAttributedLabel *message;

- (CGFloat)getCalculatedCellHeight;

@end
