#import "DEIgor.h"

@protocol SelectorEngine
- (NSArray *)selectViewsWithSelector:(NSString *)query;
@end

@interface SelectorEngineRegistry
+(void)registerSelectorEngine:(id <SelectorEngine>)engine WithName:(NSString *)name;
@end

@interface DEIgorSelfRegisteringSelectorEngine : NSObject <SelectorEngine>
@end

@implementation DEIgorSelfRegisteringSelectorEngine {
    DEIgor *_igor;
}

+ (void)applicationDidBecomeActive:(NSNotification *)notification {
  Class frankRegistry = NSClassFromString(@"SelectorEngineRegistry");
  if (frankRegistry) {
    DEIgorSelfRegisteringSelectorEngine *selectorEngine = [[DEIgorSelfRegisteringSelectorEngine alloc] initWithIgor:[DEIgor igor]];
    [frankRegistry performSelector:@selector(registerSelectorEngine:WithName:) withObject:selectorEngine withObject:@"igor"];
    NSLog(@"Igor 0.5.0 registered with Frank as selector engine named 'igor'");
  }
}

- (id)initWithIgor:(DEIgor *)igor {
    self = [super init];
    if (self) {
        _igor = igor;
    }
    return self;
}

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
#if TARGET_OF_IPHONE
                                                 name:@"UIApplicationDidBecomeActiveNotification"
#else
                                                 name:@"NSApplicationDidBecomeActiveNotification"
#endif
                                               object:nil];
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
#if TARGET_OS_IPHONE
  UIWindow *tree = [[UIApplication sharedApplication] keyWindow];
#else
  NSWindow *window = [[NSApplication sharedApplication] keyWindow];
  NSView *tree = [window contentView];
#endif
    return [_igor findViewsThatMatchQuery:query inTree:tree];
}

@end
