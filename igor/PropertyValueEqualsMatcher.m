//
//  PropertyValueEqualsSelector.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyValueEqualsMatcher.h"
#import <objc/runtime.h>

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

-(NSString* ) getterForPropertyForObject:(id)object {
    objc_property_t property = class_getProperty([object class], [matchProperty UTF8String]);
    if(!property) {
        return nil;
    }
    NSString* attributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    NSScanner* attributeScanner = [NSScanner scannerWithString:attributes];
    if(![attributeScanner scanUpToString:@",G" intoString:nil] || [attributeScanner isAtEnd]) {
        return matchProperty;
    }
    
    [attributeScanner scanString:@",G" intoString:nil];
    NSString* getterName = [NSString string];
    [attributeScanner scanUpToString:@"," intoString:&getterName];
    return getterName;
}

-(id) valueOfPropertyFor:(id) object {
    NSString* getterName = [self getterForPropertyForObject:object];
    if(!getterName) {
        return nil;
    }
    SEL selector = NSSelectorFromString(getterName);
    if(!selector) {
        return nil;
    }
    return [object performSelector:selector];
}

-(BOOL) matchesView:(UIView *)view {
    id actualValue = [self valueOfPropertyFor:view];
    return [actualValue isEqual:matchValue];
}

@end
