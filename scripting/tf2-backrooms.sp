#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <cbasenpc>

public Plugin myinfo = {
	name = "[TF2] Backrooms", 
	author = "Drixevel", 
	description = "A backrooms gamemode for Team Fortress 2.", 
	version = "1.0.0", 
	url = "https://drixevel.dev/"
};

public void OnPluginStart() {
	HookEvent("teamplay_round_start", Event_OnRoundStart);
}

public void Event_OnRoundStart(Event event, const char[] name, bool dontBroadcast) {
	//Add a slight delay so the chaser doesn't instantly gib players upon spawn and to randomize spawn locations based on where the players move.
	CreateTimer(GetRandomFloat(15.0, 30.0), Timer_SpawnChaser, _, TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_SpawnChaser(Handle timer) {

	//How many players are alive should determine how many chasers we have.
	int players = GetValidPlayers();

	//Spawn chasers based on how many players there are.
	int chasers;

	//TODO: Better way of calculating total chasers.
	if (players <= 6) {
		chasers = 1;
	} else if (players <= 12) {
		chasers = 2;
	} else if (players <= 16) {
		chasers = 3;
	}

	//Spawn the total amount of chasers.
	for (int i = 0; i < chasers; i++) {
		CreateChaser();
	}

	return Plugin_Continue;
}

//Returns the total amount of live players.
int GetValidPlayers() {
	int count;
	for (int i = 1; i <= MaxClients; i++) {
		if (IsClientInGame(i) && IsPlayerAlive(i)) {
			count++;
		}
	}
	return count;
}

//Spawns a chaser at a randomized location on the map.
void CreateChaser() {

}