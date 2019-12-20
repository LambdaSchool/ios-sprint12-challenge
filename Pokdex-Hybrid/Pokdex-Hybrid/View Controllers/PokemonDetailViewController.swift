//
//  PokemonDetailViewController.swift
//  Pokdex-Hybrid
//
//  Created by Isaac Lyons on 12/20/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    //MARK: Properties
    
    @objc var pokemonAPI: PokemonAPI?
    @objc var pokemon: Pokemon?
    
    var identifierObservation: NSKeyValueObservation?
    var abilitiesObservation: NSKeyValueObservation?
    var spriteURLObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()

        if let pokemon = pokemon {
            let name = pokemon.name.capitalized
            title = name
            nameLabel.text = "Name: \(name)"
            pokemonAPI?.fillInDetails(for: pokemon)
        }
    }
    
    @objc private func addObservers() {
        identifierObservation = observe(\.pokemon?.identifier) { _, _ in
            DispatchQueue.main.async {
                guard let pokemon = self.pokemon else { return }
                self.idLabel.text = "ID: \(pokemon.identifier)"
            }
        }
        
        abilitiesObservation = observe(\.pokemon?.abilities, changeHandler: { _, _ in
            DispatchQueue.main.async {
                guard let pokemon = self.pokemon,
                    let abilities = pokemon.abilities?.compactMap({ $0.capitalized }) else { return }
                let abilitiesString = abilities.joined(separator: ", ")
                self.abilitiesLabel.text = "Abilities: \(abilitiesString)"
            }
        })
        
        spriteURLObservation = observe(\.pokemon?.spriteURL, changeHandler: { _, _ in
            guard let pokemon = self.pokemon,
                let spriteURL = pokemon.spriteURL else { return }
            do {
                let imageData = try Data(contentsOf: spriteURL)
                guard let sprite = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    self.imageView.image = sprite
                }
            } catch {
                NSLog("\(error)")
            }
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        identifierObservation?.invalidate()
        abilitiesObservation?.invalidate()
        spriteURLObservation?.invalidate()
    }

}
