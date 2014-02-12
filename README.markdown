Features
========

GCD is a lightweight Cocoa wrapper aiming at easing development with Grand Central Dispatch.
It does support some common usage patterns, it does not wrap the whole functionality; a basic understanding of how CGD works is necessary and is not addressed on this document.

## GCDQueue ##

Easily create you own queues, or access global ones

	+ (GCDQueue*)serial:(NSString*)name;
	+ (GCDQueue*)concurrent:(NSString*)name;

	+ (GCDQueue*)main;
	+ (GCDQueue*)queue;
	+ (GCDQueue*)high;
	+ (GCDQueue*)low;
	+ (GCDQueue*)background;

Set the target queue, suspend or resume execution

	- (void)setTarget:(GCDQueue*)q;
	- (void)suspend;
	- (void)resume;

Queue blocks for execution (optionally delayed or repeated) or set a barrier to synchronize concurrent ones

	- (void)add:(dispatch_block_t)block;
	- (void)add:(dispatch_block_t)block delay:(float)t;
	- (void)add:(dispatch_block_repeated_t)block times:(NSUInteger)times;
	- (void)barrier:(dispatch_block_t)block;

Context information can be set and retrieved through Obj-C subscripting from the queue. objectForKey: retrieves context from the current queue so it can be used from a block without external references.

	- (void)setObject:(id)anObject forKeyedSubscript:(id)aKey;
	- (id)objectForKeyedSubscript:(id)aKey;
	+ (id)objectForKey:(id)aKey;

## GCDGroup ##

Create, label, suspend, resume or clear a group with a comfortable syntax.

	+ (GCDGroup*)group;
	@property (nonatomic,readwrite,strong) NSString* label;
	- (void)suspend;
	- (void)resume;
	- (void)empty;

You can choose to add blocks to a specific queue, or they will be added to the global queue.

	- (void)add:(dispatch_block_t)block;
	- (void)add:(dispatch_block_t)block queue:(GCDQueue*)queue;

To manage a block execution you can set a notification block to be executed when previously submitted blocks have executed, or wait synchronously for termination.

	- (void)notify:(dispatch_block_t)block;
	- (void)notify:(dispatch_block_t)block target:(GCDQueue*)queue;

Contact
=======

I'm Max Raber. [@raberm](https://twitter.com/raberm) on Twitter.

Questions about the code should be left as issues at https://github.com/raberm/GCD or message me on Twitter.

Dependencies
=======

None beyond Foundation.

License
=======

Copyright © 2012-2014 Massimiliano Raber

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
