//
//  PropertyValueEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "NSObject+PropertyInspector.h"
#import "PropertyValueEqualsMatcher.h"

@implementation PropertyValueEqualsMatcher

@synthesize desiredValue;

+(PropertyValueEqualsMatcher*) forProperty:(NSString*)propertyName value:(NSObject*)value {
    return [[PropertyValueEqualsMatcher alloc] initWithPropertyName:propertyName value:value];
}

-(PropertyValueEqualsMatcher*) initWithPropertyName:(NSString*)propertyName value:(NSObject*)value {
    if(self = [super initWithPropertyName:propertyName]) {
        desiredValue = value;
    }
    return self;
}

-(BOOL) matchesView:(UIView *)view {
    if(![super matchesView:view]) return NO;
    id actualValue = [view valueOfProperty:self.propertyName];
    return [actualValue isEqual:desiredValue];
}

@end
