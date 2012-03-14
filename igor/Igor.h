#import "SelectorEngineRegistry.h"

@interface Igor : NSObject<SelectorEngine>

-(NSArray*) findViewsThatMatchPattern:(NSString*)pattern fromRoot:(UIView*)root;

- (NSArray *)selectViewsWithSelector:(NSString *)pattern;


@end
