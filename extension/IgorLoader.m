//
//  IgorSelectorEngine.m
//  igor
//
//  Created by Dale Emery on 11/11/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Igor.h"
#import "SelectorEngineRegistry.h"

@interface IgorLoader : NSObject
@end

@implementation IgorLoader
+(void)load {
    [SelectorEngineRegistry registerSelectorEngine:[Igor new] WithName:@"Igor"];
}

@end
