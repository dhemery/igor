@class NodeMatcher;

@interface NodePattern : NSObject

+ (NodePattern *)forScanner:(NSScanner *)scanner;
- (NodeMatcher *)parse;

@end
