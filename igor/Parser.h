//
//  Parser.h
//  igor
//
//  Created by Dale Emery on 11/22/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "Matcher.h"

@protocol Parser <NSObject>

-(id<Matcher>) parse:(NSScanner*)scanner;

@end
