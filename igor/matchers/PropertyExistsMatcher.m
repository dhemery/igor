//
//  AttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "NSObject+PropertyInspector.h"
#import "PropertyExistsMatcher.h"

@implementation PropertyExistsMatcher

@synthesize propertyName;

+(PropertyExistsMatcher*) forProperty:(NSString*)propertyName {
    return [[PropertyExistsMatcher alloc] initWithPropertyName:(NSString*)propertyName];
}

-(PropertyExistsMatcher*) initWithPropertyName:(NSString*)thePropertyName {
    if(self = [super init]) {
        self.propertyName = thePropertyName;
    }
    return self;
}

-(BOOL) matchesView:(UIView *)view {
    return [view hasProperty:propertyName];
}

@end
