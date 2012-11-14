//
//  RASingleFingerRotationGestureRecognizer.h
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface RASingleFingerRotationGestureRecognizer : UIPanGestureRecognizer

- (CGFloat) rotationWithCenterPoint:(CGPoint)point inView:(UIView *)view;
- (CGFloat) velocityWithCenterPoint:(CGPoint)point inView:(UIView *)view;

@end
