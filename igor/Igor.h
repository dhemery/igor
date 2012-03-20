#import "SelectorEngineRegistry.h"
#import "Matcher.h"

@interface Igor : NSObject<SelectorEngine>

-(NSArray*) findViewsThatMatchPattern:(NSString*)pattern fromRoot:(UIView*)root;

- (NSArray *)selectViewsWithSelector:(NSString *)pattern;

- (void)findViewsThatMatch:(id<Matcher>)matcher fromRoot:(UIView *)root intoSet:(NSMutableSet*)matchingViews;
@end
