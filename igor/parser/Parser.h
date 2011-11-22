//
//  Parser.h
//  igor
//
//  Created by Dale Emery on 11/22/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Parser <NSObject>

-(id) parse:(NSScanner*)scanner;

@end
