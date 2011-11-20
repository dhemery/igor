#import "Igor.h"
#import "SelectorEngineRegistry.h"

@interface IgorLoader
+(void)load;
@end

@implementation IgorLoader
+(void)load {
    [SelectorEngineRegistry registerSelectorEngine:[Igor new] WithName:@"igor"];
}
@end

