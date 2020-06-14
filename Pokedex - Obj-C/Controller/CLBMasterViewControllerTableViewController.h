//
//  CLBMasterViewControllerTableViewController.h
//  Pokedex - Obj-C
//
//  Created by Christian Lorenzo on 6/13/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLBDetailViewController;
@class PokemonAPI;

@interface CLBMasterViewControllerTableViewController : UITableViewController

@property (strong, nonatomic) CLBDetailViewController *detailViewController;

@end


