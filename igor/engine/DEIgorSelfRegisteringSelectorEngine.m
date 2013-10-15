#import "DEIgor.h"
#import "SelectorEngine.h"

#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)
#define IGOR_VERSION_NUMBER_STRING @ STRINGIZE2(IGOR_VERSION_NUMBER)

static NSString *const version = IGOR_VERSION_NUMBER_STRING;

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

- (NSArray *) selectViewsWithSelector:(NSString *)query inWindows:(NSArray *)windows {
    return [_igor findViewsThatMatchQuery:query inTrees:windows];
}

@end
