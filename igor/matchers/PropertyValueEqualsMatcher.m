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

@synthesize matchProperty, matchValue;

-(id) initForProperty:(NSString*)propertyName value:(NSObject*)value {
    if(self = [super init]) {
        matchProperty = propertyName;
        matchValue = value;
    }
    return self;
}

+(id) forProperty:(NSString*)propertyName value:(NSObject*)value {
    return [[PropertyValueEqualsMatcher alloc] initForProperty:propertyName value:value];
}

-(BOOL) matchesView:(UIView *)view {
    if(![super matchesView:view]) return NO;
    id actualValue = [view valueOfProperty:self.matchProperty];
    return [actualValue isEqual:self.matchValue];
}

@end
