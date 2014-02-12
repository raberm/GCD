//
//  GCDQueue.m
//
//  Created by Massimiliano Raber on 15/11/12.
//  Copyright (c) 2012 Massimiliano Raber. All rights reserved.
//

#import "GCDQueue.h"

static NSMutableDictionary *keys = nil;

@interface GCDQueue ()

@property (nonatomic) dispatch_queue_t queue;

@end

@implementation GCDQueue

@synthesize label;
@synthesize queue;

+ (GCDQueue*)main
{
	static GCDQueue* q = nil;
	if (!q)
	{
		q = [GCDQueue new];
		q.queue = dispatch_get_main_queue();
	}
	return q;
}

+ (GCDQueue*)serial:(NSString*)name
{
	GCDQueue* q = [GCDQueue new];
	q.queue = dispatch_queue_create(name.UTF8String, DISPATCH_QUEUE_SERIAL);
	return q;
}

+ (GCDQueue*)concurrent:(NSString*)name
{
	GCDQueue* q = [GCDQueue new];
	q.queue = dispatch_queue_create(name.UTF8String, DISPATCH_QUEUE_CONCURRENT);
	return q;
}

+ (GCDQueue*)queue
{
	static GCDQueue* q = nil;
	if (!q)
	{
		q = [GCDQueue new];
		q.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	}
	return q;
}

+ (GCDQueue*)high
{
	static GCDQueue* q = nil;
	if (!q)
	{
		q = [GCDQueue new];
		q.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	}
	return q;
}

+ (GCDQueue*)low
{
	static GCDQueue* q = nil;
	if (!q)
	{
		q = [GCDQueue new];
		q.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
	}
	return q;
}

+ (GCDQueue*)background
{
	static GCDQueue* q = nil;
	if (!q)
	{
		q = [GCDQueue new];
		q.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
	}
	return q;
}

- (NSString*)label
{
	return @(dispatch_queue_get_label(queue));
}

- (void)setTarget:(GCDQueue *)q
{
	dispatch_set_target_queue(self.queue, q.queue);
}

- (void)add:(dispatch_block_t)block
{
	dispatch_async(queue, block);
}

- (void)add:(dispatch_block_t)block delay:(float)t
{
	int64_t delayInSeconds = MAX(0.0f, t);
	dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(delayTime, queue, block);
}

- (void)add:(dispatch_block_repeated_t)block times:(NSUInteger)times
{
	dispatch_apply(times, queue, block);
}

- (void)barrier:(dispatch_block_t)block
{
	dispatch_barrier_async(queue, block);
}

- (void)suspend
{
	dispatch_suspend(queue);
}

- (void)resume
{
	dispatch_resume(queue);
}

- (void)setObject:(id)anObject forKeyedSubscript:(id)aKey
{
	if (!keys) keys = [NSMutableDictionary dictionary];

	id key = nil;
	if (!keys[aKey])
	{
		key = @([aKey hash]);
		keys[aKey] = key;
	}

	if (key)
	{
		dispatch_queue_set_specific(queue, (__bridge void*)key, (__bridge void*)anObject, nil);
	}
}

- (id)objectForKeyedSubscript:(id)aKey
{
	if (!aKey || !keys[aKey]) return nil;
	
	id key = keys[aKey];
	void *i = dispatch_queue_get_specific(queue, (__bridge void*)key);
	return (__bridge id)i;
}

+ (id)objectForKey:(id)aKey
{
	if (!aKey) return nil;

	id key = keys[aKey];
	void *i = dispatch_get_specific((__bridge void*)key);
	return (__bridge id)i;
}

@end
