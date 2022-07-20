## Alternative Auxmos
This folder contains alternatively compiled auxmos files in case if devs and contributors have problem running localhost due the way of how auxmos compiled originally.
Simply copy auxmos files from here to the root folder, overwrite.

## Compiling Auxmos
In case if above method didn't work, you might have to compile your own auxmos.
Do the following:

 0. Download and install PowerShell (7) if you don't have one. Win10 seem to provide it's own version, but not checked if it will work as well.
 1. Download auxmos from https://github.com/Putnam3145/auxmos/releases/tag/v0.2.7 **(SOURCE CODE only)**.
 2. Extract the source code somewhere.
 3. Open powershell and change directory (via `CD [path]` command) to the extracted source code folder.\
 3.1. Or right-click on the folder/empty space in it to open context menu, choose "PowerShell 7" -> "Open here".
 4. Input `rustup target add i686-pc-windows-msvc` (else you get alot of errors with next), then `cargo rustc --target=i686-pc-windows-msvc --release --features "all_reaction_hooks" -- -C target-cpu=native`.
 5. Wait for it to finish.
 6. When's all done, check `.\target\i686-pc-windows-msvc\release` folder. It should have auxmos.dll and auxmos.pdb.
 7. Copy the two and paste them in the root server folder. Overwrite.
 8. Check if Dream Daemon/VSCode now launch server without it crashing (DD) and not working(VSC).
 
## Extra
 - Until BYOND devs fix it (probably), avoid updating your BYOND version to 514.1585, since trying to localhost on it may gave out runtime errors and refuse to operate properly. If it's fine on your end, then carry on.
