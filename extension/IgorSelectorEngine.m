//
//  IgorSelectorEngine.m
//  igor
//
//  Created by Dale Emery on 11/11/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#undef DEBUG
#import "IgorSelectorEngine.h"
#import "Igor.h"

@implementation IgorSelectorEngine
+(void)load {
    [SelectorEngineRegistry registerSelectorEngine:[IgorSelectorEngine new] WithName:@"Igor"];
    NSLog(@"Registered IgorSelectorEngine as Igor");
}

- (NSArray *) selectViewsWithSelector:(NSString *)selector {
    NSLog(@"Igor selecting views for selector %@", selector);
    return [Igor selectViewsThatMatchQuery:selector];
}

@end
