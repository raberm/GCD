//
//  GCDQueue.h
//
//  Created by Massimiliano Raber on 15/11/12.
//  Copyright (c) 2012 Massimiliano Raber.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
