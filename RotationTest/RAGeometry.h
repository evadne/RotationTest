//
//  RAGeometry.h
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGFloat RARadiansNormalize (CGFloat radians);
extern CGFloat RALineAngle (CGPoint fromPoint, CGPoint toPoint);
extern CGFloat RALineDistance (CGPoint fromPoint, CGPoint toPoint);
extern CGPoint RALineMidwayPoint (CGPoint fromPoint, CGPoint toPoint, CGFloat ratio);
