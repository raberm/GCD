//
//  GCDQueue+Friend.h
//
//  Created by Massimiliano Raber on 15/11/12.
//  Copyright (c) 2012 Massimiliano Raber. All rights reserved.
//

#import "GCDQueue.h"

@interface GCDQueue (Friend)

@property (nonatomic) dispatch_queue_t queue;

@end
