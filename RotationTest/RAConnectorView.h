//
//  RAConnectorView.h
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface RAConnectorView : UIView

@property (nonatomic, readwrite, assign) CGPoint fromPoint;
@property (nonatomic, readwrite, assign) CGPoint toPoint;

@end
