HOW TO ADD COMBAT ACTIONS

1. Add action's name to appropriate enum in autoload
2. Create resource and set it's parameters
3. Add match case in ActionHandler for that action
4. Implement it's function in ActionHandler
5. Create action signal within character and emit it in that function
6. Connect that signal to character_sfx and implement SFX for that action
7. Connect that signal to character_visuals and implement VFX for that action
8. Add action resource to character's array
