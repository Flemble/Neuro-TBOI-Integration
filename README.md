# Neuro-TBOI-Integration

> [!WARNING]
> The documentation may contain SPOILERS for "The Binding of Isaac: Repentance+" be warned! 

> [!IMPORTANT]
> This project currently contains unfinished coding, missing dependencies, and is majorly untestable. Please only look through and test things **at your own discretion**. When the build is more feature-rich and stable, this message will be removed.

## A Neuro-sama Integration that allows her to play The binding of Isaac: Repentance+

This project uses repentogon's "luadebug" feature to give an Isaac mod full access to the lua standard library, this is in order to send game data that the mod "scrapes" over to the main C++ program.

> [!WARNING]
> The "luadebug" feature is dangerous, appropriate measures to address and prevent problems will be in the installation instructions when we get there.

Another thing that needs to be addressed is Neuro not knowing what items do. Luckily, our saving grace is [external item descriptions](https://github.com/wofsauge/External-Item-Descriptions) because it contains an API that the mod can "scrape" for relevant item descriptions.

After data is processed and validated by the "integration" it finally makes its way to Neuro if it needs to, otherwise it's stored inside memory to be given whenever needed.

As The Binding of Isaac is a game about Items, Information and synergies, this is actually *most* of the game covered! and it will remain a large majority of my focus on this project until I can't avoid the inevitable next feature anymore...
## Dodging, Movement and game interaction:

Currently, everything previously mentioned has been well-thought-out and I have confirmed it's possible, the difficult part comes with the integration's "dodging" feature (also movement and other things)

I'm still deciding on how this will be tackled at a MUCH later date (either through hooking into the game or using repentogon's vast and very helpful API)

I wish I could give you some more confidence here, but I am actually VERY inexperienced in this sort of area. I'll need some more time to learn how everything works to apply a clever and low l*tency solution, you'll have to be patient. 

 Making this with professionalism and clear understanding is non-negotiable due to Isaac's fast-paced gameplay and quick decision-making regarding its movement and dodging.
