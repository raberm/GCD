//
//  GCDGroup.m
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
