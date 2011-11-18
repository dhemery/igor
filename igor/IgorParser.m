//
//  IgorParser.m
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParser.h"
#import "UniversalSelector.h"
#import "ClassEqualsSelector.h"

@implementation IgorParser
-(id<Selector>) parse:(NSString*)selectorString {
    if([selectorString isEqualToString:@"*"]) {
        return [UniversalSelector new];
    } else {
        Class matchClass = NSClassFromString(selectorString);
        return [[ClassEqualsSelector alloc] initWithClass:matchClass];
    }
}
@end
