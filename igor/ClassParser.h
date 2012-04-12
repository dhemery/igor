@class IgorQueryStringScanner;
@protocol IgorQueryScanner;

@interface ClassParser : NSObject

- (void)parseClassMatcherFromQuery:(id<IgorQueryScanner>)query intoArray:(NSMutableArray*)array;

+ (ClassParser*)parser;

@end
