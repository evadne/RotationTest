//
//  RAViewController.m
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAConnectorView.h"
#import "RADraggableView.h"
#import "RAGeometry.h"
#import "RAReactionKit.h"
#import "RAThreeKnobsViewController.h"

@interface RAThreeKnobsViewController ()

@property (nonatomic, readonly, assign) CGFloat angle;
@property (nonatomic, readonly, assign) CGPoint centerPoint;
@property (nonatomic, readonly, assign) CGPoint referencePoint;
@property (nonatomic, readonly, assign) CGPoint inputPoint;

@property (nonatomic, readonly, strong) RADraggableView *centerDraggableView;
@property (nonatomic, readonly, strong) RADraggableView *referenceDraggableView;
@property (nonatomic, readonly, strong) RADraggableView *inputDraggableView;
@property (nonatomic, readonly, strong) RAConnectorView *referenceConnectorView;
@property (nonatomic, readonly, strong) RAConnectorView *inputConnectorView;

@property (nonatomic, readonly, strong) NSString *angleLabelText;
@property (nonatomic, readonly, assign) CGPoint angleLabelCenter;
@property (nonatomic, readonly, strong) UILabel *angleLabel;

@end

@implementation RAThreeKnobsViewController
@synthesize centerDraggableView = _centerDraggableView;
@synthesize referenceDraggableView = _referenceDraggableView;
@synthesize inputDraggableView = _inputDraggableView;
@synthesize referenceConnectorView = _referenceConnectorView;
@synthesize inputConnectorView = _inputConnectorView;
@synthesize angleLabel = _angleLabel;

- (void) viewDidLoad {
	
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	CGPoint centerPoint = (CGPoint){
		CGRectGetMidX(self.view.bounds),
		CGRectGetMidY(self.view.bounds)
	};
	
	RADraggableView *centerDraggableView = self.centerDraggableView;
	centerDraggableView.center = centerPoint;
	[self.view addSubview:centerDraggableView];
	
	RADraggableView *referenceDraggableView = self.referenceDraggableView;
	referenceDraggableView.center = (CGPoint){
		centerPoint.x + 128,
		centerPoint.y
	};
	[self.view addSubview:referenceDraggableView];
	
	RADraggableView *inputDraggableView = self.inputDraggableView;
	inputDraggableView.center = (CGPoint){
		centerPoint.x,
		centerPoint.y - 128
	};
	[self.view addSubview:inputDraggableView];
	[self.view addGestureRecognizer:inputDraggableView.longPressGestureRecognizer];
	[self.view addGestureRecognizer:inputDraggableView.panGestureRecognizer];
	
	[self.view addSubview:self.referenceConnectorView];
	[self.view addSubview:self.inputConnectorView];
	
	[self.view addSubview:self.angleLabel];
	
}

- (void) viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];
	
	[self addObserver:self forKeyPath:@"angle" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:(void *)self];

	[self addObserver:self forKeyPath:@"centerPoint" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:(void *)self];
	
}

- (void) viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	
	[self removeObserver:self forKeyPath:@"angle" context:(void *)self];
	[self removeObserver:self forKeyPath:@"centerPoint" context:(void *)self];
	
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

	if (object == self) {

		if ([keyPath isEqualToString:@"angle"]) {
		
			//	?
		
		} else if ([keyPath isEqualToString:@"centerPoint"]) {
		
			[self.angleLabel sizeToFit];
		
		}
	
	}

}

- (CGFloat) angle {
	
	CGPoint centerPoint = self.centerDraggableView.center;
	CGPoint inputPoint = self.inputDraggableView.center;
	
	CGFloat inputAngle = RALineAngle(centerPoint, inputPoint);
	return inputAngle;
	
}

+ (NSSet *) keyPathsForValuesAffectingAngle {

	return [NSSet setWithObjects:
		@"centerPoint",
		@"referencePoint",
		@"inputPoint",
	nil];

}

- (CGPoint) centerPoint {
	
	return self.centerDraggableView.center;
	
}

+ (NSSet *) keyPathsForValuesAffectingCenterPoint {

	return [NSSet setWithObjects:
		@"centerDraggableView.center",
	nil];

}

- (CGPoint) referencePoint {

	return self.referenceDraggableView.center;

}

+ (NSSet *) keyPathsForValuesAffectingReferencePoint {

	return [NSSet setWithObjects:
		@"referenceDraggableView.center",
	nil];

}

- (CGPoint) inputPoint {
	
	return self.inputDraggableView.center;
	
}

+ (NSSet *) keyPathsForValuesAffectingInputPoint {

	return [NSSet setWithObjects:
		@"inputDraggableView.center",
	nil];

}

- (RADraggableView *) centerDraggableView {
	
	if (!_centerDraggableView) {
	
		_centerDraggableView = [RADraggableView new];
	
	}
	
	return _centerDraggableView;
	
}

- (RADraggableView *) referenceDraggableView {

	if (!_referenceDraggableView) {
		
		_referenceDraggableView = [RADraggableView new];
		
	}
	
	return _referenceDraggableView;
	
}

- (RADraggableView *) inputDraggableView {

	if (!_inputDraggableView) {
	
		_inputDraggableView = [RADraggableView new];
	
	}
	
	return _inputDraggableView;

}

- (RAConnectorView *) referenceConnectorView {

	if (!_referenceConnectorView) {
	
		_referenceConnectorView = [RAConnectorView new];
		_referenceConnectorView.fromPoint = self.centerPoint;
		_referenceConnectorView.toPoint = self.referencePoint;
	
		[_referenceConnectorView ra_bind:@"fromPoint" toObject:self keyPath:@"centerPoint" options:@{ RABindingsMainQueueGravityOption: @YES }];
		[_referenceConnectorView ra_bind:@"toPoint" toObject:self keyPath:@"referencePoint" options:@{ RABindingsMainQueueGravityOption: @YES }];
		
	}
	
	return _referenceConnectorView;

}

- (RAConnectorView *) inputConnectorView {

	if (!_inputConnectorView) {
	
		_inputConnectorView = [RAConnectorView new];
		_inputConnectorView.fromPoint = self.centerPoint;
		_inputConnectorView.toPoint = self.inputPoint;
		
		[_inputConnectorView ra_bind:@"fromPoint" toObject:self keyPath:@"centerPoint" options:@{ RABindingsMainQueueGravityOption: @YES }];
		[_inputConnectorView ra_bind:@"toPoint" toObject:self keyPath:@"inputPoint" options:@{ RABindingsMainQueueGravityOption: @YES }];
	
	}
	
	return _inputConnectorView;

}

- (NSString *) angleLabelText {

	return [NSString stringWithFormat:@"%f", self.angle];

}

+ (NSSet *) keyPathsForValuesAffectingAngleLabelText {

	return [NSSet setWithObjects:
		@"angle",
	nil];

}

- (CGPoint) angleLabelCenter {

	return self.centerPoint;

}

+ (NSSet *) keyPathsForValuesAffectingAngleLabelCenter {

	return [NSSet setWithObjects:
		@"centerPoint",
	nil];

}

- (UILabel *) angleLabel {

	if (!_angleLabel) {
	
		_angleLabel = [UILabel new];
		_angleLabel.center = self.angleLabelCenter;
		_angleLabel.text = self. angleLabelText;
		_angleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
		_angleLabel.textColor = [UIColor whiteColor];
		_angleLabel.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
		_angleLabel.layer.cornerRadius = 8.0f;
		
		[_angleLabel ra_bind:@"center" toObject:self keyPath:@"angleLabelCenter" options:nil];
		[_angleLabel ra_bind:@"text" toObject:self keyPath:@"angleLabelText" options:nil];
		
		__weak typeof(_angleLabel) wAngleLabel = _angleLabel;
		
		[_angleLabel ra_observe:@"text" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:(void *)_angleLabel withBlock:^(NSKeyValueChange kind, id fromValue, id toValue, NSIndexSet *indices, BOOL isPrior) {
			
			NSCParameterAssert([NSThread isMainThread]);
			
			CGPoint oldCenter = wAngleLabel.center;
			[wAngleLabel sizeToFit];
			wAngleLabel.center = oldCenter;
			
		}];
	
	}
	
	return _angleLabel;

}

@end
