//
//  GCDGroup.h
//
//  Created by Massimiliano Raber on 15/11/12.
//  Copyright (c) 2012 Massimiliano Raber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDQueue.h"

@interface GCDGroup : NSObject

@property (nonatomic,readwrite,strong) NSString* label;

+ (GCDGroup*)group;

- (void)add:(dispatch_block_t)block;
- (void)add:(dispatch_block_t)block queue:(GCDQueue*)queue;
- (void)notify:(dispatch_block_t)block;
- (void)notify:(dispatch_block_t)block target:(GCDQueue*)queue;
- (void)wait;
- (void)empty;

- (void)suspend;
- (void)resume;

@end
