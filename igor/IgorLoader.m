
#import "Igor.h"
#import "SelectorEngineRegistry.h"

@interface IgorLoader
@end

@implementation IgorLoader

+(void) applicationDidBecomeActive:(NSNotification*)notification{
#ifndef DEBUG
    [SelectorEngineRegistry registerSelectorEngine:[Igor new] WithName:@"igor"];
    NSLog(@"Igor registered with Frank as selector engine named 'igor'");
#endif
}

+(void) load{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:) 
                                                 name:@"UIApplicationDidBecomeActiveNotification" 
                                               object:nil];
    NSLog(@"Igor registered to be notified when the application becomes active.");
}

@end