//
//  ShareViewController.m
//  SharingDemo
//
//  Created by TheAppGuruz-New-6 on 11/04/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import "ShareViewController.h"


@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize btnid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnFacebookClicked:(id)sender
{
    [self shareFacebook];
}

-(void) shareFacebook
{
    SLComposeViewController *fvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSLog(@"%@",btnid);
    if([btnid isEqualToString:@"1"])
    {
        [fvc setInitialText:@"Test"];
        [fvc addImage:[UIImage imageNamed:@"demo.png"]];
    }
    else if([btnid isEqualToString:@"2"])
    {
        [fvc setInitialText:@"Test"];
        [fvc addURL:[NSURL URLWithString:@"www.google.com"]];
    }
    else if([btnid isEqualToString:@"3"])
    {
        [fvc setInitialText:@"Text Sharing"];
    }
    [fvc setCompletionHandler:[self setComplitionHandlerFunction]];
    if([self isInternetConnectionAvailable])
    {
        [self presentViewController:fvc animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Internet Connection is not available"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show]; alert = nil;
        
    }
}

- (BOOL)isInternetConnectionAvailable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

-(SLComposeViewControllerCompletionHandler)setComplitionHandlerFunction
{
    SLComposeViewControllerCompletionHandler resultFB;
    if([self isInternetConnectionAvailable])
    {
        resultFB = ^(SLComposeViewControllerResult result) {
            NSString *output = @"";
            switch (result)
            {
                case SLComposeViewControllerResultCancelled:
                    output = @"";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (![output isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:output
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
                [alert show]; alert = nil;
            }
        };
    }
    return resultFB;
}


- (IBAction)btnTwitterClicked:(id)sender
{
    [self shareTwitter];
}

-(void) shareTwitter
{
    SLComposeViewController *tvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    if([btnid isEqualToString:@"1"])
    {
        [tvc setInitialText:@"Test"];
        [tvc addImage:[UIImage imageNamed:@"demo.png"]];
    }
    else if([btnid isEqualToString:@"2"])
    {
        [tvc setInitialText:@"Test"];
        [tvc addURL:[NSURL URLWithString:@"www.google.com"]];
    }
    else if([btnid isEqualToString:@"3"])
    {
        [tvc setInitialText:@"Text Sharing"];
    }
    [tvc setCompletionHandler:[self setComplitionHandlerFunction]];
    [self presentViewController:tvc animated:YES completion:nil];
}

- (IBAction)btniMessageClicked:(id)sender
{
    [self shareiMessage];
}

-(void)shareiMessage
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        if([btnid isEqualToString:@"1"])
        {
            [controller addAttachmentData:UIImageJPEGRepresentation([UIImage imageNamed:@"demo.png"], 1) typeIdentifier:@"image/jpg" filename:@"Image.png"];
        }
        else if([btnid isEqualToString:@"2"])
        {
            controller.body=@"www.google.com";
        }
        else if([btnid isEqualToString:@"3"])
        {
            controller.body=@"This is test";
        }
        controller.delegate = self;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            break;
        case MessageComposeResultSent:
            [self fileSendSuccessfully:@"Message sent successfully"];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fileSendSuccessfully:(NSString *)strMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:strMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show]; alert = nil;
}


- (IBAction)btnEmailClicked:(id)sender
{
    [self showPicker];
}

-(void)showPicker
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        if ([mailClass canSendMail]) { [self displayComposerSheet]; }
        else { [self launchMailAppOnDevice]; }
    } else {
        [self launchMailAppOnDevice];
    }
}

- (void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:&subject=";
    NSString *body = @"&body=";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"Test"];
    if([btnid isEqualToString:@"1"])
    {
        [picker addAttachmentData:UIImagePNGRepresentation([UIImage imageNamed:@"demo.png"]) mimeType:@"image/jpg" fileName:@"test.jpg"];
    }
    else if([btnid isEqualToString:@"2"])
    {
        [picker setMessageBody:@"www.google.com" isHTML:YES];
    }
    else if([btnid isEqualToString:@"3"])
    {
        [picker setMessageBody:@"This is demo." isHTML:YES];
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            [self fileSendSuccessfully:@"Mail sent successfully"];
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
