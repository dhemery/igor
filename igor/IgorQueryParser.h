@protocol Matcher;

@protocol IgorQueryParser <NSObject>

- (id <Matcher>)parseMatcherFromQuery:(NSString *)query;

@end