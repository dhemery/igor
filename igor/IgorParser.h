@class Matcher;

@interface IgorParser : NSObject

+ (IgorParser *)forPattern:(NSString *)pattern;
- (Matcher *)parse;


@end
