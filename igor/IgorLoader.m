#import "Igor.h"
#import "SelectorEngineRegistry.h"

@interface IgorLoader

+(void)load;

@end

@implementation IgorLoader

+(void)load {
#ifdef DEBUG
    NSLog(@"IgorLoader loaded");
#else
    [SelectorEngineRegistry registerSelectorEngine:[Igor new] WithName:@"igor"];
    NSLog(@"Igor registered with Frank as selector engine named 'igor'");
#endif
}
@end

