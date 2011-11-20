//
//  PropertyValueEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyInspector.h"
#import "PropertyValueEqualsSelector.h"
#import <objc/message.h>

@implementation PropertyValueEqualsSelector

@synthesize desiredValue, propertyName;

-(PropertyValueEqualsSelector*) initWithPropertyName:(NSString*)thePropertyName value:(NSObject*)theValue {
    if(self = [super init]) {
        desiredValue = theValue;
        propertyName = thePropertyName;
    }
    return self;
}

+(PropertyValueEqualsSelector*) selectorWithPropertyName:(NSString*)propertyName value:(NSObject*)value {
    return [[PropertyValueEqualsSelector alloc] initWithPropertyName:propertyName value:value];
}

-(BOOL) matchesView:(UIView *)view {
    if(![[PropertyInspector new] class:[view class] hasProperty:propertyName]) {
        return NO;
    }
    id actualValue = objc_msgSend(view, NSSelectorFromString(propertyName));
    return [actualValue isEqual:desiredValue];
}

@end
