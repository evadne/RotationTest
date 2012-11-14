//
//  RADraggableView.m
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RADraggableView.h"

@interface RADraggableView () <UIGestureRecognizerDelegate>
@end

@implementation RADraggableView
@synthesize longPressGestureRecognizer = _longPressGestureRecognizer;
@synthesize panGestureRecognizer = _panGestureRecognizer;

+ (id) new {

	CGRect rect = (CGRect){ CGPointZero, (CGSize){ 32, 32 }};
	RADraggableView *view = [[self alloc] initWithFrame:rect];
	
	return view;

}

- (id) initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	if (!self)
		return nil;
		
	CGFloat red = (CGFloat)((CGFloat)(arc4random() % 256) / 256.0f);
	CGFloat green = (CGFloat)((CGFloat)(arc4random() % 256) / 256.0f);
	CGFloat blue = (CGFloat)((CGFloat)(arc4random() % 256) / 256.0f);
	
	self.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
	
	return self;
	
}

- (UILongPressGestureRecognizer *) longPressGestureRecognizer {

	if (!_longPressGestureRecognizer) {
	
		_longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
		_longPressGestureRecognizer.delegate = self;
		_longPressGestureRecognizer.minimumPressDuration = 0.01f;
	
	}
	
	return _longPressGestureRecognizer;

}

- (UIPanGestureRecognizer *) panGestureRecognizer {

	if (!_panGestureRecognizer) {
	
		_panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
		_panGestureRecognizer.delegate = self;
	
	}
	
	return _panGestureRecognizer;

}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

	return CGRectContainsPoint(self.bounds, [touch locationInView:self]);

}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

	return YES;

}

- (void) handleLongPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer {

	switch (longPressGestureRecognizer.state) {
		
		case UIGestureRecognizerStatePossible: {
			break;
		}
		
		case UIGestureRecognizerStateBegan: {
			
			[UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
				
				self.transform = CGAffineTransformMakeScale(2.5f, 2.5f);
				self.alpha = 0.75f;
				self.center = [longPressGestureRecognizer locationInView:self.superview];
				
			} completion:nil];
			
			break;
			
		}
		
		case UIGestureRecognizerStateChanged: {
			break;
		}
		
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled:
		case UIGestureRecognizerStateFailed: {
			
			[UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
				
				self.transform = CGAffineTransformIdentity;
				self.alpha = 1.0f;
							
			} completion:nil];
			
			break;
			
		}
	}

}

- (void) handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {

	switch (panGestureRecognizer.state) {
		
		case UIGestureRecognizerStatePossible:
		case UIGestureRecognizerStateBegan: {
			break;
		}
		
		case UIGestureRecognizerStateChanged: {
			self.center = [panGestureRecognizer locationInView:self.superview];
			break;
		}
		
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled:
		case UIGestureRecognizerStateFailed: {
			break;
		}
		
	}

}

@end
