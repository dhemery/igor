#import "SelectorEngineRegistry.h"

@interface Igor : NSObject<SelectorEngine>

-(NSArray*) selectViewsWithSelector:(NSString*)selectorString;
-(NSArray*) selectViewsWithSelector:(NSString*)selectorString fromRoot:(UIView*)root;

@end
