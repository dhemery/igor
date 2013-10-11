#import "DEIgor.h"
#import "SelectorEngine.h"

#ifdef CURRENT_PRODUCT_VERSION
NSString *version= CURRENT_PRODUCT_VERSION;
#else
NSString *version = @"Unknown";
#endif

static NSString *const igorRegisteredName = @"igor";

@interface SelectorEngineRegistry
+(void)registerSelectorEngine:(id <SelectorEngine>)engine WithName:(NSString *)name;
@end

@interface DEIgorSelfRegisteringSelectorEngine : NSObject <SelectorEngine>
@end

@implementation DEIgorSelfRegisteringSelectorEngine {
    DEIgor *_igor;
}

+ (void)applicationDidBecomeActive:(NSNotification *)notification {
    [SelectorEngineRegistry registerSelectorEngine:[[DEIgorSelfRegisteringSelectorEngine alloc] initWithIgor:[DEIgor igor]] WithName:igorRegisteredName];
    NSLog(@"Igor %@ registered with Frank as selector engine named '%@'", version, igorRegisteredName);
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
                                                 name:@"UIApplicationDidBecomeActiveNotification"
                                               object:nil];
}

- (NSArray *)selectViewsWithSelector:(NSString *)query {
    UIView *tree = [[UIApplication sharedApplication] keyWindow];
    return [_igor findViewsThatMatchQuery:query inTree:tree];
}

@end
