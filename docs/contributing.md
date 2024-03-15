# How to contribute to The Maze
- Follow a Git workflow of fork -> clone -> branch -> pr -> merge
- If you're new to Git look [here](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)

## general
- Keep file and folder names in `snake_case` (godot 4 standard)

## code
- Make sure your godot code follows the [GDQuest Style Guide](https://gdquest.gitbook.io/gdquests-guidelines/godot-gdscript-guidelines), use the [gdscript-toolkit-linter](https://github.com/Scony/godot-gdscript-toolkit) to automatically format your code.
- Use [Static Typing](https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/static_typing.html) for variables and functions.
- put scenes and their scripts in the same directory
- Name scenes after the root node.
- Name scripts the same name as the node they attach to
- Label custom data structures with Class names for type hint support
- Connect signals and groups through code, NOT through the GUI.
- Each Scene should do one thing, each function should do one thing
- Make [static classes](https://godottutorials.com/courses/introduction-to-gdscript/godot-tutorials-gdscript-20/) when able.
- If a custom class/node doesn't have a position on screen or is instanced then removed, then pass it into the script as a object instead of putting in in the scene tree.
- ^ reach out to jayden if you need elaboration on this one