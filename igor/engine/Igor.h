@protocol QueryScanner;
@protocol PatternParser;

@interface Igor : NSObject

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;
+ (Igor *)igor;
+ (Igor *)igorWithParser:(id <PatternParser>)parser;

@end
