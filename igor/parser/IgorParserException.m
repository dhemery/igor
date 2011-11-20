//
//  IgorParserException.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorParserException.h"

@implementation IgorParserException
+(NSException*) exceptionWithReason:(NSString*)reason scanner:(NSScanner*)scanner {
    NSString* description = [NSString stringWithFormat:@"%@ at position %u", reason, [scanner scanLocation]];
    return [NSException exceptionWithName:@"IgorParserException" reason:description userInfo:nil];
}
@end
