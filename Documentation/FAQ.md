# Frequently Asked Questions (Even though nobody asked):

## "When will it be finished?"
> "Feature complete" and "finished" are different, previous estimations early in development have been somewhere around end of 2027, I've learnt some more since then and have decided to not try and make any deadline promises, I will be actively working hard to make this feature complete as soon as possible

> The integration will be considered "feature complete" when it's stable enough to be used and streamed by Neuro, it doesn't have to contain the entire game all at once due to how the game's progression works (I am aware natural gameplay includes progression skips so it'll still be a lot), but this is still actually a rare win for the project's deadline.

> So, when will it be "finished"? I have no idea. Once it's feature complete I will still be actively working on it, I'm not sure what the community opinion is on streaming The binding of Isaac for 600+ hours, but it is probably not a supportive one. Regardless, I still intend to finish it.

## "How does the integration work?"
> This is already explained in the [README.md](https://github.com/Flemble/Neuro-TBOI-Integration/blob/main/README.md#a-neuro-sama-integration-that-allows-her-to-play-the-binding-of-isaac-repentance)

## "What inspired you to make this"
> A major driving motivator behind this project was seeing the [Skyrim integration made by Vituha](https://github.com/vituha230/Neuro-Skyrim-Integration) in action, previously I had never given the possibility of such an integration a single thought due to the limitations of the neuro-sdk. 

> Seeing such a thing made possible made me think, "If this is possible, why wouldn't 'The binding of Isaac', one of my most favourite games, also be possible?"

> So yes, if you're reading this Vituha, thank you! Another quick thank you to Vedal as well, for making all of this possible!

## “Why does the integration do so much?”

> The binding of Isaac is an incredibly hard, input heavy game, thus a separate, dedicated system is in control of handling high APM.

> [!IMPORTANT]
> Due to the game's difficulty, I've made a controversial choice early in development to not allow Neuro to be in control of dodging enemies, however Neuro is in control of pretty much everything else! 

## “The integration calculates so much, isn’t that cheating?”
> What the integration calculates are things a player should be able to pick up on, Things that are impossible for a player to spot or are too vague are not included in that calculation,
> e.g. Neuro cannot see if a perfectly normal rock has a crawl space underneath, she cannot see rooms that are not yet displayed on the map.

## "Will you be adding support for any other mods?"
> This integration is meant to be used with [External Item Descriptions](https://github.com/wofsauge/External-Item-Descriptions), It'll use the API to directly send item descriptions to Neuro.

> Apart from that, there are no plans to add any extra mods, especially not ones that may add even more instability to the game. 

## "Will there be support for multiplayer?"
> The idea is not a fun one, the answer is likely no. while local multiplayer is not impossible, 
> it does add a lot of variables that are extremely difficult to account for, the possibility will be explored again much later in development.
 
> Since there needs to be support for complex characters like Jacob & Esau, 
> multiplayer may already end up so semi-supported that actually implementing it won't be so difficult. Again, no promises.

## “Do you use AI to develop this project?”
> I do not vibe code, share designs or ideas, nor do I theory-craft with AI at all. It ruins the fun and creativity of coding
> for me. I still recognize it as a powerful and helpful tool for debugging and menial questions, 
> so I will still use it for such things when deemed appropriate. However, I do not wish to ever learn how to use Claude or anything like that.
 
> I am aware that learning to use Claude or other intelligent agents is a recommended skill to save time.
> In fact, I will even agree. This project might be finished faster and with more understanding by doing so, but I refuse, sorry.

> [!CAUTION]
> I will be turning away anyone wishing to contribute Claude or other Agent-adjacent code.


## “Can I help with this project?”
> I’m open to any criticism, you may ask me questions and provide help in the project thread, and of course let me know about any mistakes you find anywhere.

> [!TIP]
> If you'd like to become much more involved in this project, i.e. develop it with me, you should know that I am not very experienced working with others. The answer is probably no, but don't let that dissuade you from asking, after all this is difficult for me to do by myself, and someone else taking over in an area I have no current knowledge on would be a huge burden off my shoulders.

## "How can I see your private documentation, why is it private?"
> [!IMPORTANT]
> Please don't ask for the ENTIRE private documentation, there is a reason it's private, and it will be given in full only to those that need it.

> My private documentation contains messy, unstructured info that's made only with my own convenience in mind to read and write to, It has features that need to be implemented, have already been implemented, and things I'm currently focusing on.

> It'll always be the more up-to-date documentation, containing journals, diagrams and references to resources.

> [!NOTE]
> If you would like to request the private docs, please dm me personally or ping me in the project thread with ***specifics on what you'd like to know.***
> It would be *preferred* you request only if you are a developer yourself, although that is not *required*.

## "Can I suggest features for you to add to this mod?"
> Yes that's absolutely fine, feel free to do that through the project thread, please don't dm me about things like that.
