//
//  GCDGroup.m
//
//  Created by Massimiliano Raber on 15/11/12.
//  Copyright (c) 2012 Massimiliano Raber. All rights reserved.
//

#import "GCDGroup.h"
#import "GCDQueue+Friend.h"

@interface GCDGroup ()

@property (nonatomic) dispatch_group_t group;

@end

@implementation GCDGroup

@synthesize label;
@synthesize group;

+ (GCDGroup*)group
{
	GCDGroup* g = [GCDGroup new];
	g.group = dispatch_group_create();
	return g;
}

- (void)add:(dispatch_block_t)block
{
	dispatch_group_async(group, [GCDQueue queue].queue, block);
}

- (void)add:(dispatch_block_t)block queue:(GCDQueue*)queue
{
	dispatch_group_async(group, queue.queue, block);
}

- (void)notify:(dispatch_block_t)block
{
	dispatch_group_notify(group, [GCDQueue queue].queue, block);
}

- (void)notify:(dispatch_block_t)block target:(GCDQueue*)queue
{
	dispatch_group_notify(group, queue.queue, block);
}

- (void)wait
{
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)empty
{
	dispatch_group_wait(group, DISPATCH_TIME_NOW);
}

- (void)suspend
{
	dispatch_suspend(group);
}

- (void)resume
{
	dispatch_resume(group);
}

@end
