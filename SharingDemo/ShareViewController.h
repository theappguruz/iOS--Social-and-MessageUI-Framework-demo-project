//
//  ShareViewController.h
//  SharingDemo
//
//  Created by TheAppGuruz-New-6 on 11/04/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "Reachability.h"

@interface ShareViewController : UIViewController<UINavigationControllerDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic,strong) NSString *btnid;
- (IBAction)btnFacebookClicked:(id)sender;
- (IBAction)btnTwitterClicked:(id)sender;
- (IBAction)btniMessageClicked:(id)sender;
- (IBAction)btnEmailClicked:(id)sender;

@end
