@class NodeMatcher;

@interface NodePattern : NSObject

- (NodeMatcher *)parse:(NSScanner *)scanner;

@end
