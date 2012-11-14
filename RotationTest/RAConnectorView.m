//
//  RAConnectorView.m
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAConnectorView.h"
#import "RAGeometry.h"

@interface RAConnectorView ()
@property (nonatomic, readonly, strong) UIView *headCap;
@property (nonatomic, readonly, strong) UIView *tailCap;
@end

@implementation RAConnectorView
@synthesize headCap = _headCap;
@synthesize tailCap = _tailCap;

- (id) initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	if (!self)
		return nil;
	
	self.backgroundColor = [UIColor blackColor];
	
	[self addSubview:self.headCap];
	[self addSubview:self.tailCap];
	
	return self;
	
}

- (void) setFromPoint:(CGPoint)fromPoint {

	_fromPoint = fromPoint;
	
	[self setNeedsUpdateConnection];

}

- (void) setToPoint:(CGPoint)toPoint {

	_toPoint = toPoint;
	
	[self setNeedsUpdateConnection];

}

- (void) setNeedsUpdateConnection {

	NSRunLoop *runLoop = [NSRunLoop mainRunLoop];

	[runLoop cancelPerformSelector:@selector(updateConnection) target:self argument:nil];
	
	[runLoop performSelector:@selector(updateConnection) target:self argument:nil order:0 modes:@[ NSDefaultRunLoopMode ]];

}

- (void) updateConnection {
	
	CGPoint fromPoint = self.fromPoint;
	CGPoint toPoint = self.toPoint;
	
	CGFloat angle = M_PI_2 + RALineAngle(fromPoint, toPoint);
	CGFloat distance = RALineDistance(fromPoint, toPoint);
	CGPoint centerPoint = RALineMidwayPoint(fromPoint, toPoint, 0.5f);
	
	self.bounds = (CGRect){
		CGPointZero,
		(CGSize){
			distance,
			1.0f
		}
	};
	
	self.center = centerPoint;
	self.transform = CGAffineTransformMakeRotation(angle);
	
}

- (void) layoutSubviews {

	[super layoutSubviews];
	
	self.headCap.center = (CGPoint){
		0.0f,
		0.5f * CGRectGetHeight(self.bounds)
	};
	
	self.tailCap.center = (CGPoint){
		CGRectGetWidth(self.bounds),
		0.5f * CGRectGetHeight(self.bounds)
	};

}

- (UIView *) headCap {

	if (!_headCap) {
	
		_headCap = [[UIView alloc] initWithFrame:(CGRect){ CGPointZero, (CGSize){ 8, 8 }}];
		_headCap.backgroundColor = [UIColor blackColor];
		_headCap.layer.cornerRadius = 4.0f;
		_headCap.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
	
	}
	
	return _headCap;

}

- (UIView *) tailCap {

	if (!_tailCap) {
	
		_tailCap = [[UIView alloc] initWithFrame:(CGRect){ CGPointZero, (CGSize){ 8, 8 }}];
		_tailCap.backgroundColor = [UIColor blackColor];
		_tailCap.layer.cornerRadius = 4.0f;
		_tailCap.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
	
	}
	
	return _tailCap;

}

- (NSString *) description {

	return [NSString stringWithFormat:@"<%@: %p> { fromPoint = %@, toPoint = %@ }", NSStringFromClass([self class]), self, NSStringFromCGPoint(self.fromPoint), NSStringFromCGPoint(self.toPoint)];

}

@end
