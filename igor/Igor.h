#import "SelectorEngineRegistry.h"

@interface Igor : NSObject<SelectorEngine>

-(NSArray*) selectViewsUsingShelleyWithSelector:(NSString*)pattern;
-(NSArray*) findViewsThatMatchPattern:(NSString*)pattern fromRoot:(UIView*)root;

@end
