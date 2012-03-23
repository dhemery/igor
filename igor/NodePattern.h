#import "Pattern.h"

@class NodeMatcher;

@interface NodePattern : Pattern

+ (NodePattern *)forScanner:(NSScanner *)scanner;
- (NodeMatcher *)parse;

@end
