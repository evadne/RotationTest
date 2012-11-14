//
//  RADraggableView.h
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RADraggableView : UIView

@property (nonatomic, readonly, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (nonatomic, readonly, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end
