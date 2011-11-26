//
//  AttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyExistsMatcher.h"
#import <objc/runtime.h>

@implementation PropertyExistsMatcher

@synthesize matchProperty;

-(id) initForProperty:(NSString*)thePropertyName {
    if(self = [super init]) {
        matchProperty = thePropertyName;
    }
    return self;
}

+(id) forProperty:(NSString*)propertyName {
    return [[PropertyExistsMatcher alloc] initForProperty:(NSString*)propertyName];
}

-(BOOL) matchesView:(UIView *)view {
    return class_getProperty([view class], [matchProperty UTF8String]) != nil;
}

@end
