#import "Igor.h"
#import "SelectorEngineRegistry.h"

#define DEBUG 1

@interface IgorLoader

+(void)load;

@end

@implementation IgorLoader

+(void)load {
    [SelectorEngineRegistry registerSelectorEngine:[Igor new] WithName:@"igor"];
    NSLog(@"Igor registered with Frank as selector engine named 'igor'");
}
@end

