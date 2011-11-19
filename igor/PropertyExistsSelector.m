//
//  AttributeExistsSelector.m
//  igor
//
//  Created by Dale Emery on 11/18/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyExistsSelector.h"
#import "objc/runtime.h"

@implementation PropertyExistsSelector

@synthesize propertyName;

-(PropertyExistsSelector*) initWithPropertyName:(NSString*)thePropertyName {
    if(self = [super init]) {
        self.propertyName = thePropertyName;
    }
    return self;
}

+(PropertyExistsSelector*) selectorWithPropertyName:(NSString*)propertyName {
    return [[PropertyExistsSelector alloc] initWithPropertyName:(NSString*)propertyName];
}

-(void) dumpProperties:(Class) c {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(c, &outCount);
    for(i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        NSString* itsName = [NSString stringWithUTF8String:propName];
        NSLog(@"Class %@ has property: %@", c, itsName);
    }
    free(properties);
    Class superClass = class_getSuperclass(c);
    if(superClass != NULL) {
        [self dumpProperties:superClass];
    }
}

-(BOOL) matchesView:(UIView *)view {
//    [self dumpProperties:[view class]];
    return class_getProperty([view class], [self.propertyName UTF8String]) != NULL;
}

@end
