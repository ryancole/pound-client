//
//  MessageListViewController.h
//  pound-client
//
//  Created by Ryan Cole on 12/26/12.
//  Copyright (c) 2012 Ryan Cole. All rights reserved.
//

#import "BaseViewController.h"
#import "../../Pods/SSPullToRefresh/SSPullToRefresh.h"

@interface MessageListViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, SSPullToRefreshViewDelegate>

@end
