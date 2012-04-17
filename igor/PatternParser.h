@protocol Matcher;
@protocol QueryScanner;

@protocol PatternParser <NSObject>

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner;

@end