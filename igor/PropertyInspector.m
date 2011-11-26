
#import "PropertyInspector.h"
#import <objc/runtime.h>

@implementation PropertyInspector

@synthesize propertyName;

-(id) initForProperty:(NSString*)thePropertyName {
    if(self = [super init]) {
        propertyName = thePropertyName;
    }
    return self;
}

+(id) forProperty:(NSString*)propertyName {
    return [[self alloc] initForProperty:propertyName];
}

-(id) valueReturnedFrom:(NSString*)selectorString forObject:(id) object {
    return [object performSelector:NSSelectorFromString(selectorString)];
}

-(NSString*) getterNameFor:(objc_property_t)property {
    NSString* getterStartMarker = @",G";
    NSString* getterEndMarker = @",";
    NSString* getterName = propertyName;
    NSString* attributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    NSScanner* attributeScanner = [NSScanner scannerWithString:attributes];
    if([attributeScanner scanUpToString:getterStartMarker intoString:nil] && ![attributeScanner isAtEnd]) {
        [attributeScanner scanString:getterStartMarker intoString:nil];
        [attributeScanner scanUpToString:getterEndMarker intoString:&getterName];
    }
    return getterName;
}

-(objc_property_t) propertyFor:(id)object {
    return class_getProperty([object class], [propertyName UTF8String]);
}

-(BOOL) existsOn:(id)object {
    return [self propertyFor:object] != nil;
}

-(id) valueFor:(id)object {
    objc_property_t property = [self propertyFor:object];
    NSString* getterName = [self getterNameFor:property];
    return [self valueReturnedFrom:getterName forObject:object];
}

@end
