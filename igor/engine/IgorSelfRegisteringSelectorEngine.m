#import "Igor.h"

@protocol SelectorEngine
- (NSArray *)selectViewsWithSelector:(NSString *)query;
@end

@interface SelectorEngineRegistry
+(void)registerSelectorEngine:(id <SelectorEngine>)engine WithName:(NSString *)name;
@end

@interface IgorSelfRegisteringSelectorEngine : NSObject <SelectorEngine>
@end

@implementation IgorSelfRegisteringSelectorEngine {
    Igor *_igor;
}

+ (void)applicationDidBecomeActive:(NSNotification *)notification {
    [SelectorEngineRegistry registerSelectorEngine:[[IgorSelfRegisteringSelectorEngine alloc] initWithIgor:[Igor igor]] WithName:@"igor"];
    NSLog(@"Igor 0.5.0 registered with Frank as selector engine named 'igor'");
}

- (id)initWithIgor:(Igor *)igor {
    self = [super init];
    if (self) {
        _igor = igor;
    }
    return self;
}

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:@"UIApplicationDidBecomeActiveNotification"
                                               object:nil];
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [_igor findViewsThatMatchQuery:query inTree:tree];
}

@end
