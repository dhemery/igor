//
//  PropertyDescription.h
//  igor
//
//  Created by Dale Emery on 11/20/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyDescription : NSObject

@property(readonly,retain) NSString* sourceType;
@property(readonly,retain) NSString* sourceName;
@property(readonly,retain) NSString* propertyName;

+(PropertyDescription*) descriptionWithPropertyName:(NSString*)propertyName sourceName:(NSString*)sourceName sourceType:(NSString*)sourcetype;

@end

