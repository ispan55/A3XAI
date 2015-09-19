A3XAI - Current Version: 0.1.0
=====

---
Introduction
---
A3XAI is a roaming/ambient AI spawning addon for ArmA 3 Exile mod (http://www.exilemod.com/).

---
Installing A3XAI
---
1. Download the latest A3XAI release from the A3XAI Releases page: https://github.com/dayzai/A3XAI/releases
2. Locate the .zip file you downloaded and extract it to a folder.
3. Open the extracted folder and open the Installation Package folder. Copy the contents of this folder (Addons, A3XAI_config.sqf, A3XAI_custom_defs.sqf)
4. Navigate to your server's Arma 3 folder and open the @ExileServer folder.
5. Paste the contents copied from Step 3 into this directory. When prompted to merge the "Addons" folder, click Yes. Note: No Exile files are being replaced or modified. This step merges the two Addon folders.
6. (Optional) Configure A3XAI settings by editing A3XAI_config.sqf.

---
A3XAI Features
---

* Automatically-generated static AI spawns: A3XAI will spawn an AI group at various named locations on the map if players are nearby.
* Dynamic AI spawns: A3XAI will create ambient threat in the area for each player by periodically spawning AI to create unexpected ambush encounters. These AI may occasionally seek out and hunt a player.
* Random AI spawns: A3XAI will create spawns that are randomly placed around the map and are periodically relocated. These spawns are preferentially created in named locations, but may be also created anywhere in the world.
* Air and land vehicle AI patrols: AI patrol in vehicles around the map, looking for players to hunt down. Cars and trucks may roam the road, and helicopters (or jets) search the skies for players. Helicopters with available cargo space may also occasionally deploy an AI group by parachute.
* UAV and UGV patrols: Currently an experimental feature in testing. UAVs and UGVs patrol around the map, and if armed, will engage detected players. UAVs and UGVs may also call for AI reinforcements.
* Custom AI spawns: Users may also define custom infantry and vehicle AI spawns at specified locations.
* Exile-style Respect rewards: Players gain Respect rewards for killing AI, along with bonus points for "special" kills such as long-distance kills or kill-streaks.
* Adaptive classname system: A3XAI reads Exile's trader tables to find items that AI can use, such as weapons and equipment. Users may also choose to manually specify classnames to use instead.
* Error-checking ability: A3XAI checks config files for errors upon startup. If errors are found, A3XAI will use backup settings and continue operating as normal.
* Classname verification: A3XAI filters out invalid or banned classnames and prevents them from being used by AI.
* Universal map support: A3XAI supports any and every map for Arma 3 without changing any settings.
* Plug-and-play installation: Installing and upgrading A3XAI is a simple copy and paste job and does not require modifying any Exile files.
* Easy configuration: A single configuration file contains all settings for A3XAI. This config file is external to the A3XAI pbo, so configuration changes can be made without ever having to unpack or repack the pbo file.
* Headless Client support: Offload AI calculations from your dedicated server to a headless client to improve server performance. The A3XAI HC can be started/stopped/restarted any time without causing problems.

Note: Headless clients are currently bugged in ArmA 3 1.50. It is recommended to only attempt using a headless client setup in ArmA 3 1.52+.

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.