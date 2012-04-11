#import "SelectorEngineRegistry.h"

@interface Igor : NSObject <SelectorEngine>

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;

@end
