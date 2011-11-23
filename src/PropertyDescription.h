//
//  PropertyDescription.h
//  igor
//
//  Created by Dale Emery on 11/20/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyDescription : NSObject

@property(readonly,retain) NSString* propertyName;
@property(readonly,retain) NSString* sourceName;
@property(readonly,retain) NSString* sourceType;

+(id) forProperty:(NSString*)propertyName sourceName:(NSString*)sourceName sourceType:(NSString*)sourcetype;

-(id) initWithPropertyName:(NSString*)thePropertyName sourceName:(NSString*)theSourceName sourceType:(NSString*)theSourceType;

@end

