//
//  PropertyValueEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyValueEqualsMatcher.h"

@implementation PropertyValueEqualsMatcher

@synthesize matchValue;

-(id) initForProperty:(NSString*)propertyName value:(NSObject*)value {
    if(self = [super initForProperty:propertyName]) {
        matchValue = value;
    }
    return self;
}

+(id) forProperty:(NSString*)propertyName value:(NSObject*)value {
    return [[self alloc] initForProperty:propertyName value:value];
}

-(BOOL) matchesView:(UIView *)view {
    return [super matchesView:view] && [[view valueForKey:self.matchProperty] isEqual:matchValue];
}

@end
