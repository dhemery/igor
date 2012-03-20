//
//  IgorParser.h
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import "Igor.h"

@interface IgorParser : NSObject

@property(retain,readonly) Igor* igor;

-(id) parse:(NSString*) pattern;
+(IgorParser*) forIgor:(Igor*) igor;

@end
