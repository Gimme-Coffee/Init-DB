import json
from typing import List
import requests


def mapGenOneToFive():
    pass


class Pokemon(object):
    def __init__(self, name: str):
        pokemonData = requests.get(
            'https://pokeapi.co/api/v2/pokemon/{}/'.format(name)).json()

        speciesData = requests.get(
            'https://pokeapi.co/api/v2/pokemon-species/{}/'.format(name)).json()

        self.abilities = [x['ability']['name']
                          for x in pokemonData['abilities']]

        self.baseExperience = pokemonData['base_experience']

        self.baseHappiness = speciesData['base_happiness']

        self.captureRate = speciesData['capture_rate']

        self.genus = None

        for entry in speciesData['genera']:
            if entry['language']['name'] == 'en':
                self.genus = entry['genus']

        self.color = speciesData['color']['name']

        self.eggGroups = [x['name'] for x in speciesData['egg_groups']]

        self.growthRate = speciesData['growth_rate']['name']

        swordEntry = ''
        shieldEntry = ''

        for entry in speciesData['flavor_text_entries']:
            if entry['language']['name'] == 'en':
                if entry['version']['name'] == 'sword':
                    swordEntry = entry['flavor_text']

                if entry['version']['name'] == 'shield':
                    shieldEntry = entry['flavor_text']

        self.flavorText = [swordEntry, shieldEntry]

        self.genderRatio = speciesData['gender_rate'] / 8

        self.habitat = speciesData['habitat']['name']

        self.hasGenderDifferences = speciesData['has_gender_differences']

        self.height = pokemonData['height']

        self.heldItems = [x['item']['name'] for x in pokemonData['held_items']]

        self.id = speciesData['id']

        self.isBaby = speciesData['is_baby']

        self.isLegendary = speciesData['is_legendary']

        self.isMythical = speciesData['is_mythical']

        self.moves = {}

        for m in pokemonData['moves']:
            moveName = m['move']['name']
            lastData = m['version_group_details'][-1]

            learnLevel = lastData['level_learned_at']
            learnMethod = lastData['move_learn_method']['name']

            self.moves[moveName] = {learnLevel, learnMethod}

        self.name = speciesData['name']

        self.shape = speciesData['shape']['name']

        statOrder = ['hp', 'atk', 'def', 'spa', 'spd', 'spe']
        statValues = [x['base_stat'] for x in pokemonData['stats']]

        self.stats = dict(zip(statOrder, statValues))

        self.types = [x['type']['name'] for x in pokemonData['types']]

        self.weight = pokemonData['weight']


def downloadData():
    # for i in range(1, 899):
    #     pokemon = Pokemon(str(i))
    #     break

    pokemon = Pokemon('eevee')


def downloadSprites():
    with open('data.json') as json_file:
        fileNames = json.load(json_file)['files']

    for f in fileNames:
        animatedFrontUrl = f'https://play.pokemonshowdown.com/sprites/gen5ani/{f}'
        animatedBackUrl = f'https://play.pokemonshowdown.com/sprites/gen5ani-back/{f}'

        animatedShinyFrontUrl = f'https://play.pokemonshowdown.com/sprites/gen5ani-shiny/{f}'
        animatedShinyBackUrl = f'https://play.pokemonshowdown.com/sprites/gen5ani-back-shiny/{f}'

        r = requests.get(animatedFrontUrl)

        with open(f'./sprites/front/{f}', 'wb') as x:
            x.write(r.content)

        r = requests.get(animatedBackUrl)

        with open(f'./sprites/back/{f}', 'wb') as x:
            x.write(r.content)

        r = requests.get(animatedShinyFrontUrl)

        with open(f'./sprites/front-shiny/{f}', 'wb') as x:
            x.write(r.content)

        r = requests.get(animatedShinyBackUrl)

        with open(f'./sprites/back-shiny/{f}', 'wb') as x:
            x.write(r.content)


if __name__ == "__main__":
    # downloadData()
    downloadSprites()
