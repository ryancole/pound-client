//
//  ChannelListViewController.h
//  pound-client
//
//  Created by Ryan Cole on 12/30/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "BaseViewController.h"
#import "../../Pods/SSPullToRefresh/SSPullToRefresh.h"

@interface ChannelListViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, SSPullToRefreshViewDelegate>

@end
