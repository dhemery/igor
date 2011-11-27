//
//  AttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/NSKeyValueCoding.h>
#import "PropertyExistsMatcher.h"

@implementation PropertyExistsMatcher

@synthesize matchProperty;

+(id) forProperty:(NSString*)propertyName {
    return [[self alloc] initForProperty:(NSString*)propertyName];
}

-(id) initForProperty:(NSString*)propertyName {
    if(self = [super init]) {
        matchProperty = propertyName;
    }
    return self;
}

-(BOOL) matchesView:(UIView *)view {
    @try {
        [view valueForKey:self.matchProperty];
        return YES;
    }
    @catch (NSException* e) {
        if([[e name] isEqual:NSUndefinedKeyException]) {
            return NO;
        } else {
            @throw(e);
        }
    }
}

@end
