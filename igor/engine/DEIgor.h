@protocol DEQueryScanner;
@protocol DEPatternParser;

@interface DEIgor : NSObject

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;
+ (DEIgor *)igor;
+ (DEIgor *)igorWithParser:(id <DEPatternParser>)parser;

@end
