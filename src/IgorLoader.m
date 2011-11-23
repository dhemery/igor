#import "Igor.h"
#import "SelectorEngineRegistry.h"

#define DEBUG 1

@interface IgorLoader

+(void)load;

@end

@implementation IgorLoader

+(void)load {
    [SelectorEngineRegistry registerSelectorEngine:[Igor new] WithName:@"igor"];
    NSLog(@"Igor selector engine registered with Frank as 'igor'. Woo hoo!");
}
@end

