#import "Pattern.h"

@class NodeMatcher;

@interface NodePattern : Pattern

+ (NodePattern *)forScanner:(PatternScanner *)scanner;

- (NodeMatcher *)parse;

@end
