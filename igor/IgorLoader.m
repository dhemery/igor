#import "Igor.h"

@interface IgorLoader
@end

@implementation IgorLoader

+ (void)applicationDidBecomeActive:(NSNotification *)notification {
    [SelectorEngineRegistry registerSelectorEngine:[Igor igor] WithName:@"igor"];
    NSLog(@"Igor registered with Frank as selector engine named 'igor'");
}

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:@"UIApplicationDidBecomeActiveNotification"
                                               object:nil];
    NSLog(@"Igor registered to be notified when the application becomes active.");
}

@end
