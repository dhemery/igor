//
//  PropertyParser.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyParser.h"
#import "PropertyExistsSelector.h"

@implementation PropertyParser

-(id<Selector>) parse:(NSScanner*)scanner {
    NSString* propertyName = [NSString string];
    if([scanner scanString:@"[" intoString:nil] &&
       [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&propertyName] &&
       [scanner scanString:@"]" intoString:nil]) {
        return [PropertyExistsSelector selectorWithPropertyName:propertyName];
    }
    return nil;
}

@end
