//
//  GCDQueue.h
//
//  Created by Massimiliano Raber on 15/11/12.
//  Copyright (c) 2012 Massimiliano Raber. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^dispatch_block_repeated_t)(size_t);

@interface GCDQueue : NSObject

@property (nonatomic,readonly) NSString* label;

+ (GCDQueue*)serial:(NSString*)name;
+ (GCDQueue*)concurrent:(NSString*)name;
+ (GCDQueue*)main;
+ (GCDQueue*)queue;
+ (GCDQueue*)high;
+ (GCDQueue*)low;
+ (GCDQueue*)background;

- (void)add:(dispatch_block_t)block;
- (void)add:(dispatch_block_t)block delay:(float)t;
- (void)add:(dispatch_block_repeated_t)block times:(NSUInteger)times;
- (void)barrier:(dispatch_block_t)block;
- (void)suspend;
- (void)resume;
- (void)setTarget:(GCDQueue*)q;

- (void)setObject:(id)anObject forKeyedSubscript:(id)aKey;
- (id)objectForKeyedSubscript:(id)aKey;
+ (id)objectForKey:(id)aKey;

@end
