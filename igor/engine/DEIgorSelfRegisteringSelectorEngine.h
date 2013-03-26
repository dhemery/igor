#import "DEIgor.h"

@protocol SelectorEngine
- (NSArray *)selectViewsWithSelector:(NSString *)query;
@end

@interface SelectorEngineRegistry
+(void)registerSelectorEngine:(id <SelectorEngine>)engine WithName:(NSString *)name;
@end

@interface DEIgorSelfRegisteringSelectorEngine : NSObject <SelectorEngine>
@end
