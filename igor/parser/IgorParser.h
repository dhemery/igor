//
//  IgorParser.h
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Matcher.h"

@interface IgorParser : NSObject

-(id<Matcher>) parse:(NSString*)selectorString;

@end
