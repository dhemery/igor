@class ClassMatcher;

@interface ClassPattern : NSObject

- (ClassMatcher *)parse:(NSScanner *)scanner;

@end
