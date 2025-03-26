#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\gametypes_zm\spawnlogic;
#include maps\mp\gametypes_zm\_hostmigration;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\gametypes_zm\_hud_message;


init()
{
    level endon("end_game");
    level thread onplayerconnect();
}

onplayerconnect()
{
    for(;;)
        {
            level waittill("connected",player);
            player thread onplayerspawn();
            player thread ZombieCounter();
            player thread HeathCounter();
            player thread HealthMax();
            player thread ZombieLeftCounter();
        }
}

onplayerspawn()
{
    level endon("game_ended");
    self endon("disconnect");
    self.zombiesvisible = true;
    for(;;)
        {
            self waittill("spawned_player");
        }
}

ZombieCounter()
{
    level endon("end_game");
    self endon("disconnect");
    
    //creating Zombies word
    
    flag_wait( "initial_blackscreen_passed" );
    self.zombie_text= createFontString("Objective", 1);
    self.zombie_text setpoint ("CENTER", "CENTER", 320, 220);
    self.zombie_text setText("Zombies");
    
    //creating actual counter
    
    self.zombie_counter = createFontString ("small", 1);
    self.zombie_counter setpoint ("CENTER", "CENTER", 345, 220); 
    self.zombie_counter.label = &"";
    self.zombie_counter.alpha = 1;
    
    //main backend

    while(true)
        {
            if(level.zombie_total + get_current_zombie_count() > 50 ) 
                {
                    self.zombie_counter.color = (1, 0, 0); //🔴 
                }
            else
                {
                    self.zombie_counter.color = (0, 1, 0); //🟢
                } 
        self.zombie_counter setvalue(level.zombie_total + get_current_zombie_count());
        wait 0.05;
        }
}

ZombieLeftCounter()
{
    level endon("end_game");
    self endon("disconnect");
    flag_wait( "initial_blackscreen_passed" );
    
//creating Zombies word
    
    self.zombie1_text = createFontString("Objective", 1.5);
    self.zombie1_text setpoint ("CENTER", "CENTER", -387, 130);
    self.zombie1_text setText("Zombies Alive");
    
//creating actual counter
    
    self.zombie1_counter = createFontString ("small", 1.5);
    self.zombie1_counter setpoint("CENTER", "CENTER", -340, 130);
    self.zombie1_counter.label = &"";
    self.zombie1_counter.alpha = 1;
    
//main backend
    
        while(true)
            {
                if(get_current_zombie_count() > 18 )
                    {
                        self.zombie1_counter.color = (1, 0, 0); //🔴 
                    }
                else if(get_current_zombie_count() > 12 )
                    {
                        self.zombie1_counter.color = (1, 1, 0); // 🟡 
                    }
                else
                    {
                        self.zombie1_counter.color = (0, 1, 0); //🟢
                    }
                self.zombie1_counter setvalue (get_current_zombie_count());
                wait 0.05;
            }
}

HeathCounter()
{
    level endon("end_game");
    self endon("disconnect");
    flag_wait( "initial_blackscreen_passed" );
    
//creating Health word
    
    self.health_text = createFontString("Objective", 1.5);
    self.health_text setpoint ("CENTER", "CENTER", -405, 90);
    self.health_text setText("Health");
    
// middle slash
    
    self.slash = createFontString("small", 1.5);
    self.slash setpoint ("CENTER","CENTER", -360, 90);
    self.slash setText("/");
    
//creating current counter
    
    self.health_current = createFontString("small", 1.5);
    self.health_current setpoint ("CENTER","CENTER", -375, 90);
    self.health_current.label = &"";
    self.health_current.alpha = 1;
    
//main backend health_current
    
    while(true)
            {
            if(self.health > 170)
                {
                    self.health_current.color = (0, 1, 0); //full 🟢 
                }  
            else if(self.health > 130)
                {
                    self.health_current.color = (1, 1, 0); //medium 🟡 
                }
            else if(self.health > 80)
                {
                    self.health_current.color = (1, 0.5, 0); //low 🟠 
                }
            else
                {
                    self.health_current.color = (1, 0, 0); //very low 🔴 
                }
            self.health_current setvalue(self.health);
        wait 0.05;
        }
}

//creating max counter
HealthMax()
{
    level endon("end_game");
    self endon("disconnect");
    flag_wait( "initial_blackscreen_passed" );
    self.health_max = createFontString("small", 1.5);
    self.health_max setpoint ("CENTER", "CENTER", -345, 90);
    self.health_max.label = &"";
    self.health_max.alpha = 1;
    
//main backend health_max
    while(true)
        {     
            if(self.maxhealth == 250)
                {
                    self.health_max.color = (0, 1, 0); //🟢
                }
            else if(self.maxhealth == 100)
                {
                    self.health_max.color = (1, 0.5, 0); //🟡
                }
                self.health_max setvalue(self.maxhealth);
        wait 0.05;
        }
}










