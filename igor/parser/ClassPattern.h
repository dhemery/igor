//
//  ClassParser.h
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassMatcher.h"

@interface ClassPattern : NSObject

-(ClassMatcher*) parse:(NSScanner*)scanner;

@end
