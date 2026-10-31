# If you see any mistakes or inaccuracies within this documentation, please report it to the discord project thread
## This is to show *some* of my "proof of concept" work so far, anything mentioned is subject to complete change later down the line when coding
> [!IMPORTANT]
> I do have a more private, technical, in-depth and WAY MORE up-to-date documentation, you may request to see sections of it for your own research purposes, check the [FAQ](https://github.com/Flemble/Neuro-TBOI-Integration/blob/main/Documentation/FAQ.md#how-can-i-see-your-private-documentation-why-is-it-private) for more info.
### You may notice things below don't actually TELL you how anything works, due to these features not being implemented yet, I'm unable to tell you how they will work with confidence, but they will be implemented!

## What the code should do (Neuro isn’t involved):

- Avoid immediate danger
- Sort enemies in a room into groups
- Calculate all possible things to do in a cleared room
- Calculate rooms for map exploration
- Collect all coins, bombs, hearts, etc. that are reachable
- Pathfind to doors
- Avoid running into Items or trinkets and leave the decisions for Neuro where applicable

## Some short examples of what Neuro would be able to do:

CATEGORY, EXPLORE
- Choose which door to go through
- Choose what to explore in a cleared room

CATEGORY, THE PATH
- Choose if she wants to do boss rush
- Choose if she wants to do Hush
- Choose Cathedral or Sheol
- Choose if she wants to do the alt path from repentance

CATEGORY, DECISION
- Choose if she wants to take an item
- Choose to take polaroid or negative
- Choose if she wants to go to devil/angel room

CATEGORY, UI
- Choose her character
- Choose difficulty
- Choose if she wants to start a challenge

CATEGORY, SHOP
- Choose if she wants to use or blow up the donation machine
- Choose if she wants to use or blow up the reroll machine
- Choose what she wants to buy
- Choose blowing up the shopkeeper

## Some short examples of Context to give neuro
### (SOME BETTER SUITED FOR [ACTION STATE](https://github.com/VedalAI/neuro-sdk/blob/main/API/SPECIFICATION.md#parameters-5) OR [DESCRIPTION](https://github.com/VedalAI/neuro-sdk/blob/main/API/SPECIFICATION.md#parameters-1))
### In the actual Integration there will be hundreds of different contexts to give Neuro

CATEGORY, PLAYER:
- What the player’s tears look like
- What the player currently looks like

CATEGORY, ENTITIES:
- What bosses look like
- What enemies look like
- If the player has died, and what they died to

CATEGORY, ENVIRONMENT:
- If she has picked up something interesting (trinket/card/pill)
- If a room is special, and the properties of that room
- What an item looks like

CATEGORY, IMPORTANT INFO:
- What the item in the item room does, what it contributes to (if applicable)
- Where she is on the map
- What rooms are near her

CATEGORY, STORY:
- What’s going on in a cutscene
