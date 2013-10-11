#include "SelectorEngine.h"

@interface SelectorEngineRegistry : NSObject
+ (void) registerSelectorEngine:(id)engine WithName:(NSString*)name;
@end

@implementation SelectorEngineRegistry
+ (void) registerSelectorEngine:(id <SelectorEngine>)engine WithName:(NSString*)name {
    NSLog(@"Selector engine %@ registered with the test app: %@", name, engine);
}
@end
