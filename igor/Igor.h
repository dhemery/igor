#import "SelectorEngineRegistry.h"
#import "Matcher.h"

@interface Igor : NSObject<SelectorEngine>
-(NSArray*) findViewsThatMatchPattern:(NSString*)pattern fromRoot:(UIView*)root;
-(NSArray*) selectViewsWithSelector:(NSString *)pattern;
@end
