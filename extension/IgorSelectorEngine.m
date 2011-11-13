//
//  IgorSelectorEngine.m
//  igor
//
//  Created by Dale Emery on 11/11/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "IgorSelectorEngine.h"
#import "Igor.h"

@implementation IgorSelectorEngine
+(void)load {
    [SelectorEngineRegistry registerSelectorEngine:[IgorSelectorEngine new] WithName:@"Igor"];
    
}

- (NSArray *) selectViewsUsingShelleyWithSelector:(NSString *)selector {
    return [Igor selectViewsThatMatchQuery:selector];
}

@end
