
@interface PropertyInspector : NSObject

@property(retain) NSString* propertyName;

+(id) forProperty:(NSString*) propertyName;
-(BOOL) existsOn:(id)object;
-(id) valueFor:(id)object;

@end
