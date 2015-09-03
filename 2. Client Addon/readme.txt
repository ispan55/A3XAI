A3XAI Client Optional Addon
----------------------------

1. How to install
------------------
The A3XAI client optional addon is used by A3XAI to run client-side commands. To install:
1. Unpack your mission pbo file (example: Exile.Altis.pbo) and copy the A3XAI_Client folder into the extracted folder.
2. Edit your extracted mission folder's initPlayerLocal.sqf and insert this at the end:

	#include "A3XAI_Client\A3XAI_initclient.sqf";

3. Repack your mission pbo file.
4. In your server's A3XAI_config.sqf, you may now enable features supported by the A3XAI Client Addon:
	
	A3XAI_radioMsgs: 		Enables text message warnings to players with radios when they are under pursuit by AI.
	A3XAI_deathMessages: 	Enables death messages for killing AI units. Messages are displayed to player who killed the AI unit. 
							If the player is in a vehicle, all crew members are notified if at least one crew member has a Radio in their inventory.


2. How to configure
------------------
Edit A3XAI_client_config.sqf to change settings and enable/disable features. By default, all features are enabled.
