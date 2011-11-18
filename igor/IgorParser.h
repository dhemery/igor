//
//  IgorParser.h
//  igor
//
//  Created by Dale Emery on 11/17/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Selector.h"

@interface IgorParser : NSObject
-(id<Selector>) parse:(NSString*)selectorString;
@end
