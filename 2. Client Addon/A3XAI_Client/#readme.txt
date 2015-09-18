A3XAI Client Optional Addon
----------------------------

How to install
------------------

	The A3XAI client optional addon is used by A3XAI to run client-side commands. To install:

	1. Copy the A3XAI_Client folder into your mission pbo file.
	2. Edit your mission file's init.sqf and insert this near the bottom OR inside of any "if (!isDedicated) then { " bracket. (this file will not be run on the server).

		_nul = [] execVM "A3XAI_Client\A3XAI_initclient.sqf";
		
	3. Repack your mission pbo file.
	4. In your server's A3XAI_config.sqf, ensure A3XAI_clientRadio is set to "true";

