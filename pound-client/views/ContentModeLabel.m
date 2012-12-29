//
//  VerticalAlignedLabel.m
//  pound-client
//
//  Created by Ryan Cole on 12/28/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "ContentModeLabel.h"

@implementation ContentModeLabel

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGSize sizeThatFits = [self sizeThatFits:rect.size];
    
    if (self.contentMode == UIViewContentModeTop) {
        
        rect.size.height = MIN(rect.size.height, sizeThatFits.height);
        
    } else if (self.contentMode == UIViewContentModeBottom) {
        
        rect.origin.y = MAX(0, rect.size.height - sizeThatFits.height);
        rect.size.height = MIN(rect.size.height, sizeThatFits.height);
        
    }
    
    [super drawTextInRect:rect];
}

@end
