//
//  PropertyInspector.m
//  igor
//
//  Created by Dale Emery on 11/19/11.
//  Copyright (c) 2011 Dale H. Emery. All rights reserved.
//

#import "PropertyInspector.h"
#import "PropertyDescription.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation PropertyInspector

-(void) gatherProtocolsAdoptedByProtocol:(Protocol*)protocol into:(NSMutableSet*)set {
    unsigned int protocolCount;
    Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList(protocol, &protocolCount);
    for(int i = 0; i < protocolCount; i++)
    {
        [set addObject:protocols[i]];
        [self gatherProtocolsAdoptedByProtocol:protocols[i] into:set];
    }
    free(protocols);
}

-(void) gatherProtocolsOfClass:(Class)c into:(NSMutableSet*)set {
    unsigned int protocolCount;
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList(c, &protocolCount);
    for(int i = 0; i < protocolCount; i++)
    {
        [set addObject:protocols[i]];
        [self gatherProtocolsAdoptedByProtocol:protocols[i] into:set];
    }
    free(protocols);
}

-(void) gatherProperties:(objc_property_t*)properties withCount:(unsigned int)count sourceType:(NSString*)sourceType sourceName:(NSString*)sourceName into:(NSMutableSet*)set {
    for(int i = 0; i < count; i++)
    {
        NSString* propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        PropertyDescription* description = [PropertyDescription descriptionWithPropertyName:propertyName
                                                                                 sourceName:sourceName
                                                                                 sourceType:sourceType];
        [set addObject:description];
    }
}

-(void) gatherPropertiesDeclaredOnProtocol:(Protocol*)protocol into:(NSMutableSet*)set {
    NSString* protocolName = [NSString stringWithUTF8String:protocol_getName(protocol)];
    unsigned int propertyCount;
    objc_property_t *properties = protocol_copyPropertyList(protocol, &propertyCount);
    [self gatherProperties:properties
                 withCount:propertyCount
                sourceType:@"Protocol"
                sourceName:protocolName
                      into:set];
    free(properties);
}

-(void) gatherPropertiesDeclaredOnClass:(Class)c into:(NSMutableSet*)set {
    NSString* className = [c description];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(c, &propertyCount);
    [self gatherProperties:properties
                 withCount:propertyCount
                sourceType:@"Class"
                sourceName:className
                      into:set];
    free(properties);
}

-(NSSet*) propertyDescriptionsForClass:(Class) c {
    NSMutableArray* classes = [NSMutableArray arrayWithObject:c];
    Class theClass = c;
    Class superClass;
    while((superClass = [theClass superclass])) {
        [classes addObject:superClass];
        theClass = superClass;
    }
    
    NSMutableSet* protocols = [NSMutableSet set];
    NSMutableSet* properties = [NSMutableSet set];
    for(Class each in classes) {
        [self gatherProtocolsOfClass:each into:protocols];
    }
    
    for(Class each in classes) {
        [self gatherPropertiesDeclaredOnClass:each into:properties];
    }
    
    for(Protocol* each in protocols) {
        [self gatherPropertiesDeclaredOnProtocol:each into:properties];
    }
    return properties;
}

-(void) logPropertyDescriptionsForClass:(Class)c {
    NSDictionary* dictionary = [NSMutableDictionary dictionary];
    for(PropertyDescription* description in [self propertyDescriptionsForClass:c]) {
        [dictionary setValue:description forKey:description.propertyName];
    }
    for(NSString* propertyName in [self sortedPropertyNamesForClass:c]) {
        NSLog(@"%@", [dictionary valueForKey:propertyName]);
    }
}

-(NSSet*) propertyNamesFromDescriptions:(NSSet*)descriptions {
    NSMutableSet* propertyNames = [NSMutableSet set];
    for(PropertyDescription* property in descriptions) {
        [propertyNames addObject:property.propertyName];
    }
    return propertyNames;
}

-(NSSet*) propertyNamesForClass:(Class) c {
    return [self propertyNamesFromDescriptions:[self propertyDescriptionsForClass:c]];
}

-(NSArray*) sortedStringsFromSet:(NSSet*)set {
    return [[set allObjects] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSArray*) sortedPropertyNamesForClass:(Class)c {
    return [self sortedStringsFromSet:[self propertyNamesForClass:c]];
}

-(BOOL) object:(id)object hasProperty:(NSString*)propertyName {
    NSSet* properties = [self propertyNamesForClass:[object class]];
    return [properties containsObject:propertyName];
}

-(id) valueOfProperty:(NSString*)propertyName forObject:(id)object {
    return objc_msgSend(object, NSSelectorFromString(propertyName));
}

@end
