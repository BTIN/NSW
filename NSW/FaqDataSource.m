//
//  FaqDataSource.m
//  NSW
//
//  Created by Stephen Grinich on 7/21/14.
//  Copyright (c) 2014 BTIN. All rights reserved.
//

#import "FaqDataSource.h"
#import "FaqItem.h"

@implementation FaqDataSource

NSMutableArray *parsedFaq;


- (id)init {
    self = [super initWithDataFromFile:@"faq.html"];
    
    return self;
}

- (void)parseLocalData{
    [self parseFaqFromHtml];
    [super parseLocalData];
}

-(void)parseFaqFromHtml{
    
    parsedFaq = [[NSMutableArray alloc] init];
    NSString *rawHTML = [[NSString alloc] initWithData:self.localData encoding:NSUTF8StringEncoding];
    NSString *afterModuleNav = [rawHTML componentsSeparatedByString:@"moduleNav"][1];
    NSString *pertinentContent = [afterModuleNav componentsSeparatedByString:@"<div class=\"feedLink\">"][0];

    NSString *itemPrefixPattern = @"<li class=\"item number\\d+?\"><strong><a href=";
    NSString *dummy =  @" NEVERSEETHIS ";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:itemPrefixPattern options:0 error:nil];
    NSRange range = NSMakeRange(0, [pertinentContent length]);
    NSString *modified = [regex stringByReplacingMatchesInString:pertinentContent options:0 range:range withTemplate:dummy];

    NSMutableArray *splitFaqLines = (NSMutableArray *) [modified componentsSeparatedByString:dummy];
    [splitFaqLines removeObjectAtIndex:0];
    
    
    for (id obj in splitFaqLines){
        FaqItem *currentFAQ = [self parseItemFromString:obj];
        [parsedFaq addObject:currentFAQ];
    }
    
    // Send the data to the view controller if there's one linked, otherwise
    // copy it into self.dataList to be retrieved once a VC has been linked
    if (myTableViewController != nil){
        [myTableViewController setVCArrayToDataSourceArray:parsedFaq];
    } else {
        self.dataList = [NSArray arrayWithArray:parsedFaq];
    }
    
    

    
}

- (FaqItem *)parseItemFromString:(NSString *) htmlContact {
    
    NSString *question;
    NSString *answer;
    
    question = [self getQuestionFromString:htmlContact];
    answer = [self getAnswerFromString:htmlContact];
    
    return [[FaqItem alloc] initWithQuestion:question Answer:answer];
    
}


//Returns string "?faq_id=xxxxxx" for some ID xxxxx
- (NSString *)getIDFromString:(NSString *) htmlContact {
    NSString *beforeIDString = @"><strong><a href=\"";
    //everything after "><strong><a href="
    NSString *afterHREF =[htmlContact componentsSeparatedByString:beforeIDString][0];
    //everything before ">"
    NSString *idString = [afterHREF componentsSeparatedByString:@"\">"][0];
    
    return idString;
}

// Gets question portion of FAQ item
- (NSString *)getQuestionFromString:(NSString *) htmlContact {
    NSString *beforeDescriptionPattern = @"<strong><a href=\"?faq_id=\\d+?\">";
    NSString *dummy =  @" NEVERSEETHIS ";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:beforeDescriptionPattern options:0 error:nil];
    NSRange range = NSMakeRange(0, [htmlContact length]);
    NSString *modified = [regex stringByReplacingMatchesInString:htmlContact options:0 range:range withTemplate:dummy];
    NSString *splitItems =  [modified componentsSeparatedByString:@">"][1];
    NSString *question = [splitItems componentsSeparatedByString:@"</a"][0];
    
    
    return question;
    
}

// returns answer to FAQ question
-(NSString *)getAnswerFromString:(NSString *) htmlContact{
    NSString *idNumberstring;
    NSString *question = [self getQuestionFromString:htmlContact];
    idNumberstring = [self getIDFromString:htmlContact];
    NSString *answer;
    
    NSLog(question);
    
    idNumberstring = [idNumberstring componentsSeparatedByString:@"\""][1];
    NSString *urlBeforeID = @"https://apps.carleton.edu/newstudents/contact/faq/";
    NSString *answerURL = [NSString stringWithFormat:@"%@%@",urlBeforeID,idNumberstring];
    NSURL *urlRequest = [NSURL URLWithString:answerURL];
    NSError *err = nil;
    
    NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    if(err)
    {
        //Not connected to internet?
        NSLog(@"URL ERROR");
    }
    
    
    NSString *questionAndHTML = [NSString stringWithFormat:@"%@%@",question,@"</h3>"];
    NSString *afterQuestion = [html componentsSeparatedByString:questionAndHTML][1];
    NSString *almostAnswer = [afterQuestion componentsSeparatedByString:@"</p><ul class"][0];
    
    // if <div class=\"answer\"><p> is in almostAnswer
    if ([almostAnswer rangeOfString:@"<div class=\"answer\"><p>"].location != NSNotFound) {
        almostAnswer = [almostAnswer componentsSeparatedByString:@"<div class=\"answer\"><p>"][1];
    }
    
    // if <div class="answer"><p class="MsoNormal"> is in almostAnswer
    if ([almostAnswer rangeOfString:@"<div class=\"answer\"><p class=\"MsoNormal\">"].location != NSNotFound) {
        almostAnswer = [almostAnswer componentsSeparatedByString:@"<div class=\"answer\"><p class=\"MsoNormal\">"][1];
    }
    
    
    
    answer = [almostAnswer stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    answer = [answer stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    

    
    
    return answer;
    
    
}







@end
