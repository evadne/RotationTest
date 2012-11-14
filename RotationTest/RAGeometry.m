//
//  RAGeometry.m
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAGeometry.h"

extern CGFloat RASlopeForLine (CGPoint fromPoint, CGPoint toPoint);
extern CGFloat RAIntersectionAngle (CGFloat lhsSlope, CGFloat rhsSlope);

CGFloat RARadiansNormalize (CGFloat radians) {

	CGFloat answer = radians;
	NSCParameterAssert(0 <= answer < 2 * M_PI);	//	will fail
	return answer;

};

CGFloat RASlopeForLine (CGPoint fromPoint, CGPoint toPoint) {

	return (toPoint.y - fromPoint.y) / (toPoint.x - fromPoint.x);

}

CGFloat RALineAngle (CGPoint fromPoint, CGPoint toPoint) {

	CGPoint horizontallyIncrementedPoint = (CGPoint){
		fromPoint.x + 128.0f,
		fromPoint.y
	};

	CGFloat smallestAngle = RAIntersectionAngle(
		RASlopeForLine(fromPoint, horizontallyIncrementedPoint),
		RASlopeForLine(fromPoint, toPoint)
	);
	
	if ((toPoint.x > fromPoint.x) && (toPoint.y > fromPoint.y)) {
	
		return M_PI_2 + smallestAngle;
	
	} else if ((toPoint.x == fromPoint.x) && (toPoint.y > fromPoint.y)) {
	
		return 0.0;
	
	} else if ((toPoint.x < fromPoint.x) && (toPoint.y > fromPoint.y)) {
	
		return 3 * M_PI_2 + smallestAngle;
	
	} else if ((toPoint.x < fromPoint.x) && (toPoint.y == fromPoint.y)) {
	
		return 3 * M_PI_2;
	
	} else if ((toPoint.x < fromPoint.x) && (toPoint.y < fromPoint.y)) {
	
		return 3 * M_PI_2 + smallestAngle;
	
	} else if ((toPoint.x == fromPoint.x) && (toPoint.y < fromPoint.y)) {
	
		return 2 * M_PI;
	
	} else if ((toPoint.x > fromPoint.x) && (toPoint.y < fromPoint.y)) {
	
		return M_PI_2 + smallestAngle;
		
	} else if ((toPoint.x > fromPoint.x) && (toPoint.y == fromPoint.y)) {
	
		return M_PI_2;
	
	} else {
	
		return 0.0;
	
	}

}

CGFloat RAIntersectionAngle (CGFloat lhsSlope, CGFloat rhsSlope) {

	return ((lhsSlope == 0.0f) && (rhsSlope == -INFINITY)) ?
		-M_PI_2 :
		atanf((rhsSlope - lhsSlope) / 1 - (rhsSlope * lhsSlope));
	
}

CGFloat RALineDistance (CGPoint fromPoint, CGPoint toPoint) {

	return sqrtf(
		powf(fromPoint.x - toPoint.x, 2) +
		powf(fromPoint.y - toPoint.y, 2)
	);

}

CGPoint RALineMidwayPoint (CGPoint fromPoint, CGPoint toPoint, CGFloat ratio) {

	return (CGPoint){
		roundf(ratio * (toPoint.x + fromPoint.x)),
		roundf(ratio * (toPoint.y + fromPoint.y))
	};

}
