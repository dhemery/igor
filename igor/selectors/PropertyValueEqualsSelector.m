//
//  PropertyValueEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "NSObject+PropertyInspector.h"
#import "PropertyValueEqualsSelector.h"

@implementation PropertyValueEqualsSelector

@synthesize desiredValue;

-(PropertyValueEqualsSelector*) initWithPropertyName:(NSString*)thePropertyName value:(NSObject*)theValue {
    if(self = [super initWithPropertyName:thePropertyName]) {
        desiredValue = theValue;
    }
    return self;
}

+(PropertyValueEqualsSelector*) selectorWithPropertyName:(NSString*)propertyName value:(NSObject*)value {
    return [[PropertyValueEqualsSelector alloc] initWithPropertyName:propertyName value:value];
}

-(BOOL) matchesView:(UIView *)view {
    if(![super matchesView:view]) return NO;
    id actualValue = [view valueOfProperty:self.propertyName];
    return [actualValue isEqual:desiredValue];
}

@end
