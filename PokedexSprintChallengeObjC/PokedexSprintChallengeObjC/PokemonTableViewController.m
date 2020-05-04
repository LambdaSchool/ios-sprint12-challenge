//
//  PokemonTableViewController.m
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "PokedexSprintChallengeObjC-Swift.h"
#import "Pokemon.h"

@interface PokemonTableViewController ()

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.controller = PokemonController.sharedController;
    
    [self.controller fetchAllPokemonWithCompletion:^(NSMutableArray<Pokemon *> * _Nullable allPokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (allPokemon) {
            self.allPokemon = allPokemon;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    
    Pokemon *pokemon = self.allPokemon[indexPath.row];
    
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetailSegue"]) {
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Pokemon *pokemon = self.allPokemon[indexPath.row];
        
        detailVC.pokemon = pokemon;
        detailVC.controller = self.controller;
    }
}


@end
