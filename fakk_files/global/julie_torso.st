////////////////////////////////////////////////////////////////
//
// Standing
//
////////////////////////////////////////////////////////////////

state STAND
   {
   movetype legs

   camera behind

   entrycommands
      {
      takepain 1
      }

   states
      {
      KILLED                     : KILLED
      PAIN                       : PAIN

      VEHICLE_IDLE               : IN_VEHICLE
      PICKUP_STAND               : HAVE_SHGLIEK

      PUTAWAY_LEFT               : PUTAWAYLEFT
      PUTAWAY_RIGHT              : PUTAWAYRIGHT
      PUTAWAY_DUAL               : PUTAWAYBOTH

      FAKEPLAYER                 : FAKEPLAYERACTIVE ONGROUND !HAS_WEAPON LEGS "STAND"
      STAND_TO_CROUCH            : ONGROUND +CROUCH
      STAND_TO_HUG               : ONGROUND +BACKWARD !HAS_WEAPON CAN_WALL_HUG

      // don't try climbing if USE is pressed, this allows us to easily push objects and
      // also climb on them, when appropriate
      CLIMB_32                   : ONGROUND FORWARD !USE LEDGE_HEIGHT "31" "63"  SPECIALMOVE "dualhand"
      CLIMB_64                   : ONGROUND FORWARD !USE LEDGE_HEIGHT "63" "95"  SPECIALMOVE "dualhand"
      CLIMB_96                   : ONGROUND FORWARD !USE LEDGE_HEIGHT "95" "127" SPECIALMOVE "dualhand"

      ROPE_GRAB                  : !ONGROUND TOUCHED_ROPE SPECIALMOVE "dualhand"
      ROPE_USE                   : ONGROUND USE TOUCHED_ROPE SPECIALMOVE "dualhand"
      HANG                       : ONGROUND CAN_GRAB_LEDGE +FORWARD !CROUCH !BACKWARD !STRAFE_RIGHT !STRAFE_LEFT !USE SPECIALMOVE "dualhand"
      MONKEYBAR_GRAB             : ONGROUND CAN_GRAB_MONKEYBARS FORWARD !CROUCH !BACKWARD !STRAFE_RIGHT !STRAFE_LEFT SPECIALMOVE "dualhand"
      PIPEHANG_GRAB              : ONGROUND CAN_GRAB_PIPE FORWARD !BACKWARD !CROUCH !STRAFE_RIGHT !STRAFE_LEFT SPECIALMOVE "dualhand"
      HANG                       : !ONGROUND CAN_GRAB_LEDGE SPECIALMOVE "dualhand"
      MONKEYBAR_GRAB             : !ONGROUND !FALLING CAN_GRAB_MONKEYBARS SPECIALMOVE "dualhand"
      PIPEHANG_GRAB              : !ONGROUND !FALLING CAN_GRAB_PIPE !CROUCH SPECIALMOVE "dualhand"
      CLIMB_WALL_IMPACT          : !ONGROUND FORWARD !BACKWARD AT_LADDER SPECIALMOVE "dualhand"
      CLIMB_WALL                 : ONGROUND +FORWARD !BACKWARD AT_LADDER SPECIALMOVE "dualhand"

      USE_USEANIM                : ONGROUND TOUCHEDUSEANIM
      USE_USEANIM                : ONGROUND USE AT_USEANIM
      OPEN_DOOR                  : ONGROUND USE AT_DOOR
      STAND_TO_PUSH              : ONGROUND +USE CAN_PUSH
      STAND_TO_PUSH              : ONGROUND +USE CAN_PULL
      USE_USEOBJECT              : ONGROUND USE AT_USEOBJECT
      DO_COOL_ITEM               : ONGROUND GOT_COOL_ITEM

      // these are down here because picking up shglieks requires you to put away your weaponry
      PICKUP_SHGLIEK             : ONGROUND USE AT_SHGLIEK
      PICKUP_SHGLIEK             : ONGROUND PICKUP_ENEMY
      GENERIC_USE                : ONGROUND +USE

      RAISE_WEAPON               : NEW_WEAPON
      AIM                        : TARGET_ACQUIRED "any" !DUALWIELD IS_WEAPON_READY_TO_FIRE_NOSOUND "lefthand"
      AIM                        : TARGET_ACQUIRED "any" !DUALWIELD IS_WEAPON_READY_TO_FIRE_NOSOUND "righthand"

      // Check all the charge weapons
      START_CHARGE_ATTACK_DUAL_PRI : ATTACKLEFT  IS_DUALWEAPON_READY_TO_FIRE "primary" "Sling"
      START_CHARGE_ATTACK_DUAL_PRI : ATTACKRIGHT IS_DUALWEAPON_READY_TO_FIRE "alternate" "Sling"
      START_CHARGE_ATTACK_DUAL_PRI : ATTACKLEFT  IS_DUALWEAPON_READY_TO_FIRE "primary" "GasSling"
      START_CHARGE_ATTACK_DUAL_PRI : ATTACKRIGHT IS_DUALWEAPON_READY_TO_FIRE "alternate" "GasSling"
      START_CHARGE_ATTACK_DUAL_PRI : ATTACKLEFT  IS_DUALWEAPON_READY_TO_FIRE "primary" "AsteroidSling"
      START_CHARGE_ATTACK_DUAL_PRI : ATTACKRIGHT IS_DUALWEAPON_READY_TO_FIRE "alternate" "AsteroidSling"

      START_CHARGE_ATTACK_LEFT     : ATTACKLEFT  IS_WEAPON_READY_TO_FIRE "lefthand"  "Crossbow"
      START_CHARGE_ATTACK_RIGHT    : ATTACKRIGHT IS_WEAPON_READY_TO_FIRE "righthand" "Crossbow"

      CHECK_ATTACK_BOTH            : ATTACKLEFT ATTACKRIGHT IS_WEAPON_READY_TO_FIRE "lefthand" IS_WEAPON_READY_TO_FIRE "righthand"

      CHECK_ATTACK_LEFT            : ATTACKLEFT  IS_DUALWEAPON_READY_TO_FIRE "primary"
      CHECK_ATTACK_RIGHT           : ATTACKRIGHT IS_DUALWEAPON_READY_TO_FIRE "alternate"
      CHECK_ATTACK_LEFT            : ATTACKLEFT  IS_WEAPON_READY_TO_FIRE     "lefthand"
      CHECK_ATTACK_RIGHT           : ATTACKRIGHT IS_WEAPON_READY_TO_FIRE     "righthand"

      UNHOLSTER                    : ATTACKRIGHTBUTTON !FAKEPLAYERACTIVE !HAS_WEAPON !NEW_WEAPON !DUALWIELD WEAPONS_HOLSTERED
      UNHOLSTER                    : ATTACKLEFTBUTTON  !FAKEPLAYERACTIVE !HAS_WEAPON !NEW_WEAPON !DUALWIELD WEAPONS_HOLSTERED

      BUMP_INTO_WALL               : ONGROUND BLOCKED "3"
      DUAL_WIELD                   : DUALWIELD
      }

   torso
      {
      // Default the torso to the weapon holding animation if we are using a special weapon
      stand_dual_hold_shotgun       : IS_WEAPON_ACTIVE "dualhand" "Shotgun"
      stand_dual_hold_flamethrower  : IS_WEAPON_ACTIVE "dualhand" "Flamethrower"
      stand_dual_hold_chaingun      : IS_WEAPON_ACTIVE "dualhand" "Chaingun"
      stand_dual_hold_rlauncher     : IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      stand_dual_hold_soulsucker    : IS_WEAPON_ACTIVE "dualhand" "Soulsucker"
      dual_hold_sword               : IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      dual_hold_sword               : IS_WEAPON_ACTIVE "dualhand" "Axe"
      dual_hold_sword               : IS_WEAPON_ACTIVE "dualhand" "LightSword"
      }
   }

state BUMP_INTO_WALL
   {
   movetype anim

   legs
      {
      none          : ANY_WEAPON_ACTIVE "dualhand"
      run_into_wall : default
      }

   states
      {
      KILLED               : KILLED
      CLIMB_32             : ONGROUND FORWARD LEDGE_HEIGHT "31" "63" !BACKWARD !STRAFE_RIGHT !STRAFE_LEFT !ANY_WEAPON_ACTIVE "dualhand"
      CLIMB_64             : ONGROUND FORWARD LEDGE_HEIGHT "63" "95" !BACKWARD !STRAFE_RIGHT !STRAFE_LEFT !ANY_WEAPON_ACTIVE "dualhand"
      CLIMB_96             : ONGROUND FORWARD LEDGE_HEIGHT "95" "127" !BACKWARD !STRAFE_RIGHT !STRAFE_LEFT !ANY_WEAPON_ACTIVE "dualhand"

      ROPE_GRAB            : !ONGROUND TOUCHED_ROPE
      HANG                 : CAN_GRAB_LEDGE FORWARD !BACKWARD !CROUCH !STRAFE_RIGHT !STRAFE_LEFT
      MONKEYBAR_GRAB       : CAN_GRAB_MONKEYBARS FORWARD !BACKWARD !CROUCH !STRAFE_RIGHT !STRAFE_LEFT
      PIPEHANG_GRAB        : CAN_GRAB_PIPE FORWARD !BACKWARD !CROUCH !STRAFE_RIGHT !STRAFE_LEFT
      STAND                : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Crouching / Rolling
//
////////////////////////////////////////////////////////////////

state STAND_TO_CROUCH
   {
   camera behind_nopitch

   movetype anim

   legs
      {
      stand_to_crouch : default
      }

   states
      {
      KILLED_FROM_KNEE     : KILLED
      STAND                : FALLING
      //CROUCH_IDLE          : ANIMDONE_LEGS // Now we go right to the CROUCH_IDLE state to make crouching faster
      CROUCH_IDLE          : default
      }

   exitcommands
      {
      safeholster 1
      }
   }

state CROUCH_TO_STAND
   {
   movetype anim

   legs
      {
      crouch_to_stand : default
      }

   states
      {
      KILLED_FROM_KNEE     : KILLED
      STAND                : ANIMDONE_LEGS
      STAND                : FALLING
      }
   exitcommands
      {
      safeholster 0
      }
   }

state OUT_OF_CROUCH
   {
   states
      {
      STAND : default
      }

   exitcommands
      {
      safeholster 0
      }
   }

state CROUCH_IDLE
   {
   camera behind_nopitch
   movetype crouch

   legs
      {
      crouch_idle_22_right_low    : SLOPE_22 LEFT_LEG_HIGH
      crouch_idle_22_left_low     : SLOPE_22 RIGHT_LEG_HIGH
      crouch_idle_45_right_low    : SLOPE_45 LEFT_LEG_HIGH
      crouch_idle_45_left_low     : SLOPE_45 RIGHT_LEG_HIGH
      crouch_idle_22_front_low    : SLOPE_22 FACING_DOWN_SLOPE
      crouch_idle_22_rear_low     : SLOPE_22 FACING_UP_SLOPE
      crouch_idle_45_front_low    : SLOPE_45 FACING_DOWN_SLOPE
      crouch_idle_45_rear_low     : SLOPE_45 FACING_UP_SLOPE
      crouch_idle                 : default
      }

   states
      {
      KILLED_FROM_KNEE     : KILLED
      CROUCH_TO_STAND      : FAKEPLAYERACTIVE
      //CROUCH_TO_STAND      : +CROUCH CAN_STAND
      CROUCH_TO_STAND      : !CROUCH CAN_STAND
      CROUCH_TO_STAND      : JUMP CAN_STAND
      CROUCH_WALK_FORWARD  : FORWARD CAN_MOVE_FORWARD !CAN_FALL
      CROUCH_WALK_BACKWARD : BACKWARD CAN_MOVE_BACKWARD
      CROUCH_WALK_LEFT     : STRAFE_LEFT CAN_MOVE_LEFT
      CROUCH_WALK_RIGHT    : STRAFE_RIGHT CAN_MOVE_RIGHT
      OUT_OF_CROUCH        : FALLING
      RESTART_CROUCH_IDLE  : +FACING_UP_SLOPE
      RESTART_CROUCH_IDLE  : -FACING_UP_SLOPE
      RESTART_CROUCH_IDLE  : +FACING_DOWN_SLOPE
      RESTART_CROUCH_IDLE  : -FACING_DOWN_SLOPE
      RESTART_CROUCH_IDLE  : +RIGHT_LEG_HIGH
      RESTART_CROUCH_IDLE  : -RIGHT_LEG_HIGH
      RESTART_CROUCH_IDLE  : +LEFT_LEG_HIGH
      RESTART_CROUCH_IDLE  : -LEFT_LEG_HIGH
      RESTART_CROUCH_IDLE  : +SLOPE_22
      RESTART_CROUCH_IDLE  : -SLOPE_22
      RESTART_CROUCH_IDLE  : +SLOPE_45
      RESTART_CROUCH_IDLE  : -SLOPE_45
      }
   }

state RESTART_CROUCH_IDLE
   {
   states
      {
      CROUCH_IDLE : default
      }
   }

state CROUCH_WALK_FORWARD
   {
   camera behind_nopitch
   movetype crouch

   legs
      {
      crouchwalk_fwd       : default
      }

   states
      {
      KILLED_FROM_KNEE     : KILLED
      CROUCH_IDLE          : FAKEPLAYERACTIVE
      CROUCH_IDLE          : !FORWARD
      CROUCH_IDLE          : !CAN_MOVE_FORWARD
      CROUCH_WALK_LEFT     : STRAFE_LEFT CAN_MOVE_LEFT
      CROUCH_WALK_RIGHT    : STRAFE_RIGHT CAN_MOVE_RIGHT
      CROUCH_TO_STAND      : !CROUCH CAN_STAND
      OUT_OF_CROUCH        : FALLING
      }
   }

state CROUCH_WALK_BACKWARD
   {
   camera behind_nopitch
   movetype crouch

   legs
      {
      crouchwalk_backward  : default
      }

   states
      {
      KILLED_FROM_KNEE     : KILLED
      CROUCH_IDLE          : FAKEPLAYERACTIVE
      CROUCH_IDLE          : !BACKWARD
      CROUCH_IDLE          : !CAN_MOVE_BACKWARD
      CROUCH_WALK_LEFT     : STRAFE_LEFT CAN_MOVE_LEFT
      CROUCH_WALK_RIGHT    : STRAFE_RIGHT CAN_MOVE_RIGHT
      CROUCH_TO_STAND      : !CROUCH CAN_STAND
      OUT_OF_CROUCH        : FALLING
      }
   }

state CROUCH_WALK_LEFT
   {
   camera behind_nopitch
   movetype crouch

   legs
      {
      crouch_roll_left : default
      }

   states
      {
      KILLED_FROM_KNEE     : KILLED
      CROUCH_IDLE          : FAKEPLAYERACTIVE
      CROUCH_IDLE          : ANIMDONE_LEGS
      CROUCH_IDLE          : !CAN_MOVE_LEFT
      CROUCH_TO_STAND      : !CROUCH CAN_STAND
      OUT_OF_CROUCH        : FALLING
      }
   }

state CROUCH_WALK_RIGHT
   {
   camera behind_nopitch
   movetype crouch

   legs
      {
      crouch_roll_right : default
      }

   states
      {
      KILLED_FROM_KNEE     : KILLED
      CROUCH_IDLE          : FAKEPLAYERACTIVE
      CROUCH_IDLE          : ANIMDONE_LEGS
      CROUCH_IDLE          : !CAN_MOVE_RIGHT
      CROUCH_TO_STAND      : !CROUCH CAN_STAND
      OUT_OF_CROUCH        : FALLING
      }
   }

////////////////////////////////////////////////////////////////
//
// Wall hug
//
////////////////////////////////////////////////////////////////

state STAND_TO_HUG
   {
   movetype wallhug

   camera topdown

   legs
      {
      stand_to_hug : default
      }

   states
      {
      KILLED_FALL_FORWARD : KILLED
      HUG_IDLE            : ANIMDONE_LEGS
      }
   }

state HUG_TO_STAND
   {
   movetype wallhug

   camera topdown

   legs
      {
      hug_to_stand : default
      }

   states
      {
      KILLED_FALL_FORWARD : KILLED
      STAND               : ANIMDONE_LEGS
      }
   }

state HUG_IDLE
   {
   movetype wallhug

   camera topdown

   legs
      {
      hug_idle : default
      }

   states
      {
//      STAND                : !GROUNDENTITY
      KILLED_FALL_FORWARD  : KILLED
      HUG_TO_STAND         : FORWARD
      HUG_TO_STAND         : !CAN_WALL_HUG
      HUG_STEP_LEFT        : STRAFE_LEFT
      HUG_STEP_RIGHT       : STRAFE_RIGHT
      HUG_TWITCH           : CHANCE "0.002"
      }
   }

state HUG_TWITCH
   {
   movetype wallhug

   camera topdown

   legs
      {
      hug_twitch : default
      }

   states
      {
//      STAND                : !GROUNDENTITY
      KILLED_FALL_FORWARD  : KILLED
      HUG_TO_STAND         : FORWARD
      HUG_TO_STAND         : !CAN_WALL_HUG
      HUG_STEP_LEFT        : STRAFE_LEFT
      HUG_STEP_RIGHT       : STRAFE_RIGHT
      HUG_IDLE             : ANIMDONE_LEGS
      }
   }

state HUG_STEP_LEFT
   {
   movetype wallhug

   camera topdown

   legs
      {
      hug_step_left : default
      }

   states
      {
//      STAND               : !GROUNDENTITY
      KILLED_FALL_FORWARD : KILLED
      HUG_IDLE            : ANIMDONE_LEGS
      }
   }

state HUG_STEP_RIGHT
   {
   movetype wallhug

   camera topdown

   legs
      {
      hug_step_right : default
      }

   states
      {
//      STAND               : !GROUNDENTITY
      KILLED_FALL_FORWARD : KILLED
      HUG_IDLE            : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Hanging
//
////////////////////////////////////////////////////////////////

state PULL_UP
   {
   movetype hanging

   camera topdown

   legs
      {
      hang_pullup : default
      }

   states
      {
      KILLED      : KILLED
      STAND       : ANIMDONE_LEGS
      }
   }

//state HANG
//   {
//   movetype hanging
//
//   camera topdown
//
//   entrycommands
//      {
//      takepain 0
//      }
//
//   legs
//      {
//      hang_grab_wall    : HANG_ATWALL
//      hang_grab         : default
//      }
//
//   states
//      {
//      KILLED            : KILLED
//      HANG_IDLE         : ANIMDONE_LEGS
//      }
//   }

state HANG
   {
   movetype hanging

   camera topdown

   legs
      {
      hang_idle : default
      }

   states
      {
      KILLED            : KILLED
      HANG_MOVE_LEFT    : STRAFE_LEFT CAN_HANG_LEFT
      HANG_MOVE_RIGHT   : STRAFE_RIGHT CAN_HANG_RIGHT
      PULL_UP           : +FORWARD CAN_PULLUP
      PULL_UP           : +JUMP CAN_PULLUP
      HANG_LETGO        : BACKWARD
      HANG_LETGO        : CROUCH
      HANG_LETGO        : !CAN_HANG
      }
   }

state HANG_IDLE
   {
   movetype hanging

   camera topdown

   legs
      {
      hang_idle : default
      }

   states
      {
      KILLED            : KILLED
      HANG_MOVE_LEFT    : STRAFE_LEFT CAN_HANG_LEFT
      HANG_MOVE_RIGHT   : STRAFE_RIGHT CAN_HANG_RIGHT
      PULL_UP           : +FORWARD CAN_PULLUP
      PULL_UP           : +JUMP CAN_PULLUP
      HANG_LETGO        : BACKWARD
      HANG_LETGO        : CROUCH
      HANG_LETGO        : !CAN_HANG
      }
   }

state HANG_LETGO
   {
   movetype legs

   legs
      {
      hang_letgo : default
      }

   states
      {
      KILLED         : KILLED
      HANG_TO_CLIMB  : AT_LADDER
      STAND          : ONGROUND
      STAND          : ANIMDONE_LEGS
      }
   }

state HANG_TO_CLIMB
   {
   movetype climbwall

   legs
      {
      wall_hang_idle_to_wall_climb_idle : default
      }

   states
      {
      KILLED         : KILLED
      CLIMB_IDLE     : ANIMDONE_LEGS
      }
   }

state HANG_MOVE_LEFT
   {
   movetype hanging

   camera topdown

   legs
      {
      hang_shim_left : default
      }

   states
      {
      KILLED            : KILLED
      HANG_IDLE         : ANIMDONE_LEGS !STRAFE_LEFT
      HANG_IDLE         : ANIMDONE_LEGS !CAN_HANG_LEFT
      HANG_LETGO        : !CAN_HANG
      }
   }

state HANG_MOVE_RIGHT
   {
   movetype hanging

   camera topdown

   legs
      {
      hang_shim_right : default
      }

   states
      {
      KILLED         : KILLED
      HANG_IDLE      : ANIMDONE_LEGS !STRAFE_RIGHT
      HANG_IDLE      : ANIMDONE_LEGS !CAN_HANG_RIGHT
      HANG_LETGO     : !CAN_HANG
      }
   }

////////////////////////////////////////////////////////////////
//
// Wall climbing
//
////////////////////////////////////////////////////////////////

state CLIMB_WALL
   {
   movetype climbwall

   camera behind_fixed

   entrycommands
      {
      takepain 0
      }

   legs
      {
      stand_to_wall_climb : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : ANIMDONE_LEGS
      }
   }

state CLIMB_WALL_IMPACT
   {
   entrycommands
      {
      sound snd_wallclimbimpact
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : default
      }
   }

state CLIMB_IDLE
   {
   movetype climbwall

   camera behind_fixed

   legs
      {
      wall_climb_idle : FEET_AT_LADDER
      wall_climb_nolegs_idle : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_UP          : FORWARD CAN_CLIMB_LADDER "0" "0" "32"
      CLIMB_DOWN        : BACKWARD CAN_CLIMB_LADDER "0" "0" "-32"
      CLIMB_LEFT        : STRAFE_LEFT FEET_AT_LADDER CAN_CLIMB_LADDER "0" "32" "0"
      CLIMB_RIGHT       : STRAFE_RIGHT FEET_AT_LADDER CAN_CLIMB_LADDER "0" "-32" "0"
      CLIMB_LEFT_NOLEGS : STRAFE_LEFT !FEET_AT_LADDER CAN_CLIMB_LADDER "0" "29" "0"
      CLIMB_RIGHT_NOLEGS : STRAFE_RIGHT !FEET_AT_LADDER CAN_CLIMB_LADDER "0" "-29" "0"
      STAND             : !AT_LADDER
      STAND             : JUMP !FORWARD !BACKWARD
      CLIMB_TO_HANG     : FORWARD CAN_GRAB_LEDGE
      //CLIMB_TO_HANG     : CAN_GRAB_LEDGE
      }
   }

state CLIMB_UP
   {
   camera behind_fixed

   legs
      {
      none : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_UP_LEFT     : CHANCE ".5"
      CLIMB_UP_RIGHT    : default
      }
   }

state CLIMB_UP_LEFT
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_left_up : FEET_AT_LADDER
      wall_climb_nolegs_left_up : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !FORWARD ANIMDONE_LEGS
      CLIMB_UP_RIGHT    : ANIMDONE_LEGS CAN_CLIMB_LADDER "0" "0" "32"
      STAND             : !AT_LADDER
      STAND             : JUMP !FORWARD
      //CLIMB_TO_HANG     : FORWARD CAN_GRAB_LEDGE
      CLIMB_TO_HANG     : CAN_GRAB_LEDGE
      CLIMB_IDLE        : -FEET_AT_LADDER
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "0" "32"
      }
   }

state CLIMB_UP_RIGHT
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_right_up : FEET_AT_LADDER
      wall_climb_nolegs_right_up : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !FORWARD ANIMDONE_LEGS
      CLIMB_UP_LEFT     : ANIMDONE_LEGS CAN_CLIMB_LADDER "0" "0" "32"
      STAND             : !AT_LADDER
      STAND             : JUMP !FORWARD
      //CLIMB_TO_HANG     : FORWARD CAN_GRAB_LEDGE
      CLIMB_TO_HANG     : CAN_GRAB_LEDGE      
      CLIMB_IDLE        : -FEET_AT_LADDER
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "0" "32"
      }
   }

state CLIMB_LEFT
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_left : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !STRAFE_LEFT ANIMDONE_LEGS
      STAND             : !AT_LADDER
      STAND             : ONGROUND
      STAND             : JUMP !STRAFE_LEFT
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "32" "0"
      //CLIMB_TO_HANG     : FORWARD CAN_GRAB_LEDGE
      CLIMB_TO_HANG     : CAN_GRAB_LEDGE      
      CLIMB_IDLE        : -FEET_AT_LADDER
      }
   }

state CLIMB_LEFT_NOLEGS
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_nolegs_left : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !STRAFE_LEFT ANIMDONE_LEGS
      STAND             : !AT_LADDER
      STAND             : ONGROUND
      STAND             : JUMP !STRAFE_LEFT
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "29" "0"
      //CLIMB_TO_HANG     : FORWARD CAN_GRAB_LEDGE
      CLIMB_TO_HANG     : CAN_GRAB_LEDGE      
      CLIMB_LEFT        : ANIMDONE_LEGS FEET_AT_LADDER
      }
   }

state CLIMB_RIGHT
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_right : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !STRAFE_RIGHT ANIMDONE_LEGS
      STAND             : !AT_LADDER
      STAND             : ONGROUND
      STAND             : JUMP !STRAFE_RIGHT
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "-32" "0"
      //CLIMB_TO_HANG     : FORWARD CAN_GRAB_LEDGE
      CLIMB_TO_HANG     : CAN_GRAB_LEDGE      
      CLIMB_IDLE        : -FEET_AT_LADDER
      }
   }

state CLIMB_RIGHT_NOLEGS
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_nolegs_right : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !STRAFE_RIGHT ANIMDONE_LEGS
      STAND             : !AT_LADDER
      STAND             : ONGROUND
      STAND             : JUMP !STRAFE_RIGHT
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "-29" "0"
      //CLIMB_TO_HANG     : FORWARD CAN_GRAB_LEDGE
      CLIMB_TO_HANG     : CAN_GRAB_LEDGE      
      CLIMB_RIGHT       : ANIMDONE_LEGS FEET_AT_LADDER
      }
   }

state CLIMB_DOWN
   {
   camera behind_fixed

   legs
      {
      none : default
      }

   states
      {
      KILLED              : KILLED
      CLIMB_DOWN_LEFT     : CHANCE ".5"
      CLIMB_DOWN_RIGHT    : default
      }
   }

state CLIMB_DOWN_LEFT
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_left_down : FEET_AT_LADDER
      wall_climb_nolegs_left_down : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !BACKWARD ANIMDONE_LEGS
      CLIMB_DOWN_RIGHT  : ANIMDONE_LEGS CAN_CLIMB_LADDER "0" "0" "-32"
      STAND             : !AT_LADDER
      STAND             : JUMP !BACKWARD
      CLIMB_IDLE        : -FEET_AT_LADDER
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "0" "-32"
      }
   }

state CLIMB_DOWN_RIGHT
   {
   camera behind_fixed

   movetype climbwall

   legs
      {
      wall_climb_right_down : FEET_AT_LADDER
      wall_climb_nolegs_right_down : default
      }

   states
      {
      KILLED            : KILLED
      CLIMB_IDLE        : !BACKWARD ANIMDONE_LEGS
      CLIMB_DOWN_LEFT   : ANIMDONE_LEGS CAN_CLIMB_LADDER "0" "0" "-32"
      STAND             : !AT_LADDER
      STAND             : JUMP !BACKWARD
      CLIMB_IDLE        : -FEET_AT_LADDER
      CLIMB_IDLE        : ANIMDONE_LEGS !CAN_CLIMB_LADDER "0" "0" "-32"
      }
   }
state CLIMB_TO_HANG
   {
   movetype climbwall

   legs
      {
      wall_climb_idle_to_wall_hang_idle : default
      }

   states
      {
      KILLED            : KILLED
      HANG_IDLE         : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Step up
//
////////////////////////////////////////////////////////////////

state CLIMB_32
   {
   movetype stepup

   legs
      {
      stand_to_climb_32 : default
      }

   states
      {
      STAND : ANIMDONE_LEGS
      }
   }

state CLIMB_64
   {
   movetype stepup

   legs
      {
      stand_to_climb_64 : default
      }

   states
      {
      STAND : ANIMDONE_LEGS
      }
   }

state CLIMB_96
   {
   movetype stepup

   legs
      {
      stand_to_climb_96 : default
      }

   states
      {
      STAND : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Rope
//
////////////////////////////////////////////////////////////////

state ROPE_USE
   {
   movetype rope_grab

   legs
      {
      stand_to_ropeclimb         : default
      }

   states
      {
      ROPE_RELEASE      : KILLED
      ROPE_RELEASE      : !ONROPE
      ROPE_GRAB         : ANIMDONE_LEGS
      }
   }

state ROPE_GRAB
   {
   movetype rope_grab

   entrycommands
      {
      takepain 0
      }

   legs
      {
      rope_idle_right   : default
      }

   states
      {
      ROPE_RELEASE          : KILLED
      ROPE_RELEASE          : +USE
      ROPE_RELEASE          : !ONROPE
      ROPE_CLIMB_UP_LEFT    : JUMP CAN_CLIMB_ROPE "30"
      ROPE_CLIMB_DOWN_LEFT  : CROUCH CAN_CLIMB_ROPE "-30"
      ROPE_RELEASE          : !CAN_CLIMB_ROPE "0"
      }
   }

state ROPE_GRAB_LEFT
   {
   movetype rope_grab

   legs
      {
      rope_idle_left   : default
      }

   states
      {
      ROPE_RELEASE          : KILLED
      ROPE_RELEASE          : +USE
      ROPE_RELEASE          : !ONROPE
      ROPE_CLIMB_UP_RIGHT   : JUMP CAN_CLIMB_ROPE "34"
      ROPE_CLIMB_DOWN_RIGHT : CROUCH CAN_CLIMB_ROPE "-34"
      }
   }

state ROPE_CLIMB_UP_LEFT
   {
   movetype rope_move

   legs
      {
      rope_climb_left_up     : default
      }

   states
      {
      ROPE_RELEASE      : KILLED
      ROPE_GRAB_LEFT    : ANIMDONE_LEGS
      }
   }

state ROPE_CLIMB_UP_RIGHT
   {
   movetype rope_move

   legs
      {
      rope_climb_right_up     : default
      }

   states
      {
      ROPE_RELEASE      : KILLED
      ROPE_GRAB         : ANIMDONE_LEGS
      }
   }

state ROPE_CLIMB_DOWN_LEFT
   {
   movetype rope_move

   legs
      {
      rope_climb_right_down   : default
      }

   states
      {
      ROPE_RELEASE        : KILLED
      ROPE_GRAB_LEFT      : ANIMDONE_LEGS
      }
   }

state ROPE_CLIMB_DOWN_RIGHT
   {
   movetype rope_move

   legs
      {
      rope_climb_left_down   : default
      }

   states
      {
      ROPE_RELEASE   : KILLED
      ROPE_GRAB      : ANIMDONE_LEGS
      }
   }

state ROPE_RELEASE
   {
   movetype rope_release

   legs
      {
      fall : default
      }

   states
      {
      KILLED_FALL       : KILLED
      ROPE_GRAB         : !ONGROUND TOUCHED_ROPE SPECIALMOVE "dualhand"
      STAND             : !ONROPE ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Monkey Bars
//
////////////////////////////////////////////////////////////////

state MONKEYBAR_GRAB
   {
   entrycommands
      {
      takepain 0
      }

   states
      {
      KILLED_FALL       : KILLED
      MONKEYBAR_IDLE    : default
      }
   }

state MONKEYBAR_IDLE
   {
   movetype monkeybars
   camera behind_fixed

   legs
      {
      monkeybars_idle : default
      }

   states
      {
      KILLED_FALL             : KILLED
//      MONKEYBAR_TURN_LEFT     : LEFT   CAN_TURN "22.5"
//      MONKEYBAR_TURN_RIGHT    : RIGHT  CAN_TURN "-22.5"
      MONKEYBAR_MOVE_LEFT     : STRAFE_LEFT  CAN_MOVE_LEFT
      MONKEYBAR_MOVE_RIGHT    : STRAFE_RIGHT CAN_MOVE_RIGHT
      MONKEYBAR_MOVE_FORWARD_START  : FORWARD      CAN_MOVE_FORWARD
      MONKEYBAR_MOVE_BACKWARD : BACKWARD     CAN_MOVE_BACKWARD
      HANG_LETGO              : CROUCH
      HANG_LETGO              : +JUMP
      }
   }

state MONKEYBAR_TURN_LEFT
   {
   movetype monkeybars

   legs
      {
      monkeybars_turn_left : default
      }

   entrycommands
      {
      turn -22.5
      }

   states
      {
      KILLED_FALL    : KILLED
      MONKEYBAR_IDLE : ANIMDONE_LEGS
      }
   }

state MONKEYBAR_TURN_RIGHT
   {
   movetype monkeybars

   legs
      {
      monkeybars_turn_right : default
      }

   entrycommands
      {
      turn 22.5
      }

   states
      {
      KILLED_FALL    : KILLED
      MONKEYBAR_IDLE : ANIMDONE_LEGS
      }
   }

state MONKEYBAR_MOVE_FORWARD_STOP
   {
   movetype monkeybars
   camera behind_fixed

   legs
      {
      monkeybars_stop : default
      }

   states
      {
      KILLED_FALL    : KILLED
      MONKEYBAR_IDLE : ANIMDONE_LEGS
      }
   }

state MONKEYBAR_MOVE_FORWARD_START
   {
   movetype monkeybars
   camera behind_fixed

   legs
      {
      monkeybars_start : default
      }

   states
      {
      KILLED_FALL             : KILLED
      MONKEYBAR_MOVE_FORWARD  : ANIMDONE_LEGS
      }
   }

state MONKEYBAR_MOVE_FORWARD
   {
   movetype monkeybars
   camera behind_fixed

   legs
      {
      monkeybars_forward : default
      }

   states
      {
      KILLED_FALL                   : KILLED
      HANG_LETGO                    : CROUCH
      HANG_LETGO                    : JUMP
//    MONKEYBAR_TURN_LEFT           : LEFT
//      MONKEYBAR_TURN_RIGHT          : RIGHT
      MONKEYBAR_MOVE_FORWARD_STOP   : !CAN_MOVE_FORWARD
      MONKEYBAR_MOVE_FORWARD_STOP   : !FORWARD
      }
   }

state MONKEYBAR_MOVE_BACKWARD
   {
   movetype monkeybars
   camera behind_fixed

   legs
      {
      monkeybars_backward : default
      }

   states
      {
      KILLED_FALL             : KILLED
      HANG_LETGO              : CROUCH
      HANG_LETGO              : JUMP
//      MONKEYBAR_TURN_LEFT     : LEFT
//      MONKEYBAR_TURN_RIGHT    : RIGHT
      MONKEYBAR_IDLE          : !CAN_MOVE_BACKWARD
      MONKEYBAR_IDLE          : ANIMDONE_LEGS
      }
   }

state MONKEYBAR_MOVE_LEFT
   {
   movetype monkeybars
   camera behind_fixed

   legs
      {
      monkeybars_shim_left : default
      }

   states
      {
      KILLED_FALL             : KILLED
      HANG_LETGO              : CROUCH
      HANG_LETGO              : JUMP
//      MONKEYBAR_TURN_LEFT     : LEFT
//      MONKEYBAR_TURN_RIGHT    : RIGHT
      MONKEYBAR_IDLE          : !CAN_MOVE_LEFT
      MONKEYBAR_IDLE          : ANIMDONE_LEGS !STRAFE_LEFT
      }
   }

state MONKEYBAR_MOVE_RIGHT
   {
   movetype monkeybars
   camera behind_fixed

   legs
      {
      monkeybars_shim_right : default
      }

   states
      {
      KILLED_FALL             : KILLED
      HANG_LETGO              : CROUCH
      HANG_LETGO              : JUMP
      MONKEYBAR_IDLE          : !CAN_MOVE_RIGHT
      MONKEYBAR_IDLE          : ANIMDONE_LEGS !STRAFE_RIGHT
//      MONKEYBAR_TURN_LEFT     : LEFT
//      MONKEYBAR_TURN_RIGHT    : RIGHT
      }
   }

////////////////////////////////////////////////////////////////
//
// Pipe hang
//
////////////////////////////////////////////////////////////////

state PIPEHANG_GRAB
   {
   movetype pipehang
   camera side

   entrycommands
      {
      takepain 0
      }

   legs
      {
      ready_to_jump_up_to_pipe_hang : default
      }

   states
      {
      KILLED_FALL      : KILLED
      PIPEHANG_IDLE    : ANIMDONE_LEGS
      }
   }

state PIPEHANG_IDLE
   {
   movetype pipehang
   camera side

   legs
      {
      pipe_hang_idle : default
      }

   states
      {
      KILLED_FALL            : KILLED
      PIPEHANG_MOVE_FORWARD  : FORWARD CAN_MOVE_FORWARD
      PIPEHANG_MOVE_BACKWARD : BACKWARD CAN_MOVE_BACKWARD
      STAND                  : CROUCH
      PIPEHANG_TO_PIPECRAWL  : +JUMP
      }
   }

state PIPEHANG_MOVE_FORWARD
   {
   movetype pipehang
   camera side

   legs
      {
      pipe_traverse_forward : default
      }

   states
      {
      KILLED_FALL                : KILLED
      PIPEHANG_MOVE_FORWARD_STOP : !CAN_MOVE_FORWARD
      PIPEHANG_MOVE_FORWARD_STOP : ANIMDONE_LEGS !FORWARD
      PIPEHANG_MOVE_FORWARD      : ANIMDONE_LEGS
      }
   }

state PIPEHANG_MOVE_FORWARD_STOP
   {
   movetype pipehang
   camera side

   legs
      {
      pipe_traverse_stop : default
      }

   states
      {
      KILLED_FALL      : KILLED
      PIPEHANG_IDLE    : ANIMDONE_LEGS
      }
   }

state PIPEHANG_MOVE_BACKWARD
   {
   movetype pipehang
   camera side

   legs
      {
      pipe_traverse_backward : default
      }

   states
      {
      KILLED_FALL                 : KILLED
      PIPEHANG_MOVE_BACKWARD_STOP : !CAN_MOVE_BACKWARD
      PIPEHANG_MOVE_BACKWARD_STOP : ANIMDONE_LEGS !BACKWARD
      PIPEHANG_MOVE_BACKWARD      : ANIMDONE_LEGS
      }
   }

state PIPEHANG_MOVE_BACKWARD_STOP
   {
   movetype pipehang
   camera side

   legs
      {
      pipe_traverse_stop : default
      }

   states
      {
      KILLED_FALL      : KILLED
      PIPEHANG_IDLE    : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Pipe crawl
//
////////////////////////////////////////////////////////////////

state PIPEHANG_TO_PIPECRAWL
   {
   movetype pipecrawl
   camera side

   legs
      {
      pipe_hang_to_pipe_crawl : default
      }

   states
      {
      KILLED_FALL       : KILLED
      PIPECRAWL_IDLE    : ANIMDONE_LEGS
      }
   }

state PIPECRAWL_IDLE
   {
   movetype pipecrawl
   camera side

   legs
      {
      pipe_crawl_idle : default
      }

   states
      {
      KILLED_FALL             : KILLED
      PIPECRAWL_MOVE_FORWARD  : FORWARD CAN_MOVE_FORWARD
      PIPECRAWL_MOVE_BACKWARD : BACKWARD CAN_MOVE_BACKWARD
      PIPECRAWL_TO_PIPEHANG   : CROUCH
      PIPECRAWL_TO_PIPEHANG   : +JUMP
      }
   }

state PIPECRAWL_MOVE_FORWARD
   {
   movetype pipecrawl
   camera side

   legs
      {
      pipe_crawl_backward : default
      }

   states
      {
      KILLED_FALL             : KILLED
      PIPECRAWL_TO_PIPEHANG   : CROUCH
      PIPECRAWL_TO_PIPEHANG   : +JUMP
      PIPECRAWL_IDLE          : !CAN_MOVE_FORWARD
      PIPECRAWL_IDLE          : ANIMDONE_LEGS
      }
   }

state PIPECRAWL_MOVE_BACKWARD
   {
   movetype pipecrawl
   camera side

   legs
      {
      pipe_crawl_forward : default
      }

   states
      {
      KILLED_FALL             : KILLED
      PIPECRAWL_TO_PIPEHANG   : CROUCH
      PIPECRAWL_TO_PIPEHANG   : +JUMP
      PIPECRAWL_IDLE          : !CAN_MOVE_BACKWARD
      PIPECRAWL_IDLE          : ANIMDONE_LEGS
      }
   }

state PIPECRAWL_TO_PIPEHANG
   {
   movetype pipehang
   camera side

   legs
      {
      pipe_crawl_to_pipe_hang : default
      }

   states
      {
      KILLED_FALL   : KILLED
      PIPEHANG_IDLE : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Pain and death
//
////////////////////////////////////////////////////////////////

state PAIN
   {
   movetype anim

   legs
      {
      // Knockdown checks
      stand_knockdown_onback  : KNOCKDOWN PAIN_DIRECTION "Front"
      stand_knockdown_onknees : KNOCKDOWN PAIN_DIRECTION "Back"

      none                    : PAIN_TYPE "Slime"
      none                    : PAIN_TYPE "Lava"

      pain_gas                : PAIN_TYPE "Gas" PAIN_ACCUMULATED "40"

      pain_large              : PAIN_THRESHOLD "20" PAIN_DIRECTION "Front"

      pain_medium_backwards   : PAIN_THRESHOLD "10" PAIN_DIRECTION "Front"
      pain_medium_right       : PAIN_THRESHOLD "10" PAIN_DIRECTION "Right"
      pain_medium_left        : PAIN_THRESHOLD "10" PAIN_DIRECTION "Left"

      pain_small_backwards    : PAIN_THRESHOLD "6" PAIN_DIRECTION "Front"
      pain_small_right        : PAIN_THRESHOLD "6" PAIN_DIRECTION "Left"
      pain_small_left         : PAIN_THRESHOLD "6" PAIN_DIRECTION "Right"

      // check for an accumulation of pain
      stand_knockdown_onknees : PAIN_ACCUMULATED "35"

      none                    : default
      }

   states
      {
      KILLED                  : KILLED
      PAIN_IMPALED            : PAIN_TYPE "Impale"
      PAIN_FALL               : HARD_IMPACT PAIN_THRESHOLD "0"
      PAIN_STOMACH            : PAIN_THRESHOLD "10" PAIN_DIRECTION "Rear"
      STAND                   : ANIMDONE_LEGS
      }

   exitcommands
      {
      nextpaintime 1.0
      }
   }

state PAIN_IMPALED
   {
   movetype anim

   legs
      {
      pain_impaled : default
      }

   states
      {
      KILLED            : KILLED
      PAIN_IMPALED_HOLD : ANIMDONE_LEGS
      }
   }

state PAIN_IMPALED_HOLD
   {
   movetype anim

   legs
      {
      pain_impaled_hold : default
      }

   states
      {
      KILLED            : KILLED
      STAND             : FALLING
      STAND             : ONGROUND
      }
   }

state PAIN_FALL
   {
   movetype anim

   legs
      {
      pain_crouch_forward_roll : default
      }

   states
      {
      KILLED         : KILLED
      PAIN_FALL_EXIT : ANIMDONE_LEGS
      }
   }

state PAIN_FALL_EXIT
   {
   movetype anim

   legs
      {
      crouch_to_stand : default
      }

   states
      {
      KILLED : KILLED
      STAND  : ANIMDONE_LEGS
      }
   }
state PAIN_STOMACH
   {
   movetype anim

   legs
      {
      stand_knockdown_stomach : default
      }

   states
       {
       KILLED      : KILLED
       PAIN_GET_UP : ANIMDONE_LEGS
       }
   }

state PAIN_GET_UP
   {
   movetype anim

   legs
      {
      stomach_getup : default
      }

   states
       {
       KILLED  : KILLED
       STAND   : ANIMDONE_LEGS
       }
   }

state KILLED_FALL_FORWARD
   {
   movetype anim

   legs
      {
      stand_knockdown_stomach : default
      }

   states
       {
       KILLED_ON_STOMACH : ANIMDONE_LEGS
       }
   }

state KILLED_FROM_FRONT
   {
   movetype anim

   legs
      {
      death_from_front : default
      }

   states
       {
       KILLED_DONE : ANIMDONE_LEGS
       }

   exitcommands
      {
      dead
      }
   }

state KILLED_ON_STOMACH
   {
   movetype anim

   legs
      {
      death_from_stomach : default
      }

   states
       {
       KILLED_DONE : ANIMDONE_LEGS
       }

   exitcommands
      {
      dead
      }
   }

state KILLED_FROM_KNEE
   {
   movetype anim

   legs
      {
      death_from_knee : default
      }

   states
      {
      KILLED_DONE : ANIMDONE_LEGS
      }

   exitcommands
      {
      dead
      }
   }

state KILLED_FALL
   {
   movetype anim

   legs
      {
      death_fall : default
      }

   states
      {
      KILLED_FALL_IMPACT : ONGROUND
      }
   }

state KILLED_FALL_IMPACT
   {
   movetype anim

   legs
      {
      death_fall_impact : default
      }

   states
      {
      KILLED_DONE : ANIMDONE_LEGS
      }

   exitcommands
      {
      dead
      }
   }


state KILLED
   {
   movetype anim
   legs
      {
      death_from_uppercut    : PAIN_TYPE "Uppercut"
      stand_knockdown_onback : default
      }

   states
      {
      KILLED_DONE : ANIMDONE_LEGS
      }

   exitcommands
      {
      dead
      }
   }

state KILLED_DONE
   {
   camera topdown
   movetype anim
   }

////////////////////////////////////////////////////////////////
//
// Pushing
//
////////////////////////////////////////////////////////////////

state STAND_TO_PUSH
   {
   movetype push

   legs
      {
      stand_to_push : default
      }

   states
      {
      KILLED         : KILLED
      STAND          : FALLING
      PUSH_IDLE      : ANIMDONE_LEGS
      }
   }

state PUSH_IDLE
   {
   camera behind_fixed

   movetype push

   legs
      {
      push_idle : default
      }

   states
      {
      KILLED         : KILLED
      STAND          : FALLING
      PUSH_TO_STAND  : +USE
      PUSH_TO_STAND  : JUMP
      PUSH           : FORWARD CAN_PUSH
      PULL           : BACKWARD CAN_PULL
      }
   }

state PUSH
   {
   camera behind_fixed

   movetype push

   legs
      {
      push : default
      }

   states
      {
      KILLED         : KILLED
      STAND          : FALLING
      PUSH_IDLE      : !FORWARD
      PUSH_IDLE      : !CAN_PUSH
      }
   }

state PULL
   {
   camera behind_fixed

   movetype push

   legs
      {
      pull : default
      }

   states
      {
      KILLED         : KILLED
      STAND          : FALLING
      PUSH_IDLE      : !BACKWARD
      PUSH_IDLE      : !CAN_PULL
      }
   }

state PUSH_TO_STAND
   {
   movetype absolute

   legs
      {
      push_to_stand : default
      }

   states
      {
      KILLED         : KILLED
      STAND          : FALLING
      STAND          : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Open door
//
////////////////////////////////////////////////////////////////

state OPEN_DOOR
   {
   movetype anim

   legs
      {
      stand_use : default
      }

   states
      {
      STAND       : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Generic Use
//
////////////////////////////////////////////////////////////////

state GENERIC_USE
   {
   entrycommands
      {
      usestuff
      }

   states
      {
      STAND       : default
      }
   }

////////////////////////////////////////////////////////////////
//
// Standing at a UseAnim
//
////////////////////////////////////////////////////////////////

state USE_USEANIM
   {
   movetype useanim

   torso
      {
      //
      // there is no anim, since it will be stored in the use anim
      // the anim is started by the UseAnim query itself.  When we
      // transition into this state we are already playing an animation
      //
      none        : default
      }

   states
      {
      KILLED               : KILLED
      FINISH_USEANIM       : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Looping a UseAnim animation
//
////////////////////////////////////////////////////////////////

state LOOP_USEANIM
   {
   movetype absolute

   torso
      {
      //
      // there is no anim, since it will be stored in the use anim
      // the anim is started by the UseAnim query itself.  When we
      // transition into this state we are already playing an animation
      //
      none        : default
      }

   states
      {
      KILLED               : KILLED
      FINISH_USEANIM       : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finished a UseAnim animation, should we loop?
//
////////////////////////////////////////////////////////////////

state FINISH_USEANIM
   {
   movetype loopuseanim

   torso
      {
      //
      // there is no anim, since it will be stored in the use anim
      // the anim is started by the UseAnim query itself.  When we
      // transition into this state we are already playing an animation
      //
      none        : default
      }

   states
      {
      KILLED            : KILLED
      LOOP_USEANIM      : !FINISHEDUSEANIM
      FINISHED_USEANIM  : FINISHEDUSEANIM
      }
   }


////////////////////////////////////////////////////////////////
//
// Really Finished a UseAnim animation, going back to stand
//
////////////////////////////////////////////////////////////////

state FINISHED_USEANIM
   {
   movetype absolute

   entrycommands
      {
      finishuseanim
      }

   torso
      {
      //
      // there is no anim, since it will be stored in the use anim
      // the anim is started by the UseAnim query itself.  When we
      // transition into this state we are already playing an animation
      //
      none        : default
      }

   states
      {
      KILLED         : KILLED
      STAND          : default
      }
   }

////////////////////////////////////////////////////////////////
//
// Standing at a UseObject
//
////////////////////////////////////////////////////////////////

state USE_USEOBJECT
   {
   movetype useobject

   legs
      {
      //
      // there is no anim, since this state will be exited as soon as
      // we figure out which state to go into
      //
      none        : default
      }

   states
      {
      // we don't really expect to go back to stand, but this is here so we don't
      // get stuck in this state
      KILLED         : KILLED
      STAND          : default
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a Lever UseObject
//
////////////////////////////////////////////////////////////////

state USELEVER
   {
   movetype absolute

   legs
      {
      stand_to_lever    : default
      }

   states
      {
      KILLED              : KILLED
      USELEVER_START      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the lever
//
////////////////////////////////////////////////////////////////

state USELEVER_START
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      lever_push_forward    : default
      }

   states
      {
      KILLED             : KILLED
      USELEVER_STOP      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the lever
//
////////////////////////////////////////////////////////////////

state USELEVER_STOP
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      lever_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a Lever UseObject in reverse
//
////////////////////////////////////////////////////////////////

state USELEVER_BACKWARDS
   {
   movetype absolute

   legs
      {
      stand_to_lever_backward    : default
      }

   states
      {
      KILLED                        : KILLED
      USELEVER_START_BACKWARDS      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the lever in reverse
//
////////////////////////////////////////////////////////////////

state USELEVER_START_BACKWARDS
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      lever_push_backward    : default
      }

   states
      {
      KILLED                      : KILLED
      USELEVER_STOP_BACKWARD      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the lever in reverse
//
////////////////////////////////////////////////////////////////

state USELEVER_STOP_BACKWARD
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      lever_backward_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a Crank UseObject
//
////////////////////////////////////////////////////////////////

state USECRANK
   {
   movetype absolute

   legs
      {
      stand_to_crank    : default
      }

   states
      {
      KILLED              : KILLED
      USECRANK_START      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the crank
//
////////////////////////////////////////////////////////////////

state USECRANK_START
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      crank_turn_forward    : default
      }

   states
      {
      KILLED             : KILLED
      USECRANK_LOOP      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// looping the crank
//
////////////////////////////////////////////////////////////////

state USECRANK_LOOP
   {
   movetype absolute

   legs
      {
      none                  : default
      }

   states
      {
      KILLED             : KILLED
      USECRANK_START     : LOOP_USEOBJECT USE
      USECRANK_STOP      : default
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the crank
//
////////////////////////////////////////////////////////////////

state USECRANK_STOP
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      crank_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a Valve UseObject
//
////////////////////////////////////////////////////////////////

state USEVALVE
   {
   movetype absolute

   legs
      {
      stand_to_valve_forward    : default
      }

   states
      {
      KILLED              : KILLED
      USEVALVE_START      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the valve
//
////////////////////////////////////////////////////////////////

state USEVALVE_START
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      valve_turn_forward    : default
      }

   states
      {
      KILLED             : KILLED
      USEVALVE_STOP      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the valve
//
////////////////////////////////////////////////////////////////

state USEVALVE_STOP
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      valve_turn_forward_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a valve UseObject in reverse
//
////////////////////////////////////////////////////////////////

state USEVALVE_BACKWARDS
   {
   movetype absolute

   legs
      {
      stand_to_valve_backward    : default
      }

   states
      {
      KILLED                        : KILLED
      USEVALVE_START_BACKWARDS      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the valve in reverse
//
////////////////////////////////////////////////////////////////

state USEVALVE_START_BACKWARDS
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      valve_turn_backward    : default
      }

   states
      {
      KILLED                 : KILLED
      USEVALVE_STOP_BACKWARD : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the valve in reverse
//
////////////////////////////////////////////////////////////////

state USEVALVE_STOP_BACKWARD
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      valve_turn_backward_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a push button
//
////////////////////////////////////////////////////////////////

state USEBUTTON
   {
   movetype absolute

   legs
      {
      stand_to_push_button    : default
      }

   states
      {
      KILLED            : KILLED
      PUSHBUTTON_START  : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the push button
//
////////////////////////////////////////////////////////////////

state PUSHBUTTON_START
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      push_button    : default
      }

   states
      {
      KILLED          : KILLED
      PUSHBUTTON_STOP : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the push button
//
////////////////////////////////////////////////////////////////

state PUSHBUTTON_STOP
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      push_button_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a Switch UseObject
//
////////////////////////////////////////////////////////////////

state USESWITCH
   {
   movetype absolute

   legs
      {
      stand_to_switch    : default
      }

   states
      {
      KILLED               : KILLED
      USESWITCH_START      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the switch
//
////////////////////////////////////////////////////////////////

state USESWITCH_START
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      switch_activate    : default
      }

   states
      {
      KILLED              : KILLED
      USESWITCH_STOP      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the switch
//
////////////////////////////////////////////////////////////////

state USESWITCH_STOP
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      switch_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Utilizing a Switch UseObject in reverse
//
////////////////////////////////////////////////////////////////

state USESWITCH_BACKWARDS
   {
   movetype absolute

   legs
      {
      stand_to_switch_backward    : default
      }

   states
      {
      KILLED                         : KILLED
      USESWITCH_START_BACKWARDS      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Starting the actual manipulation of the switch in reverse
//
////////////////////////////////////////////////////////////////

state USESWITCH_START_BACKWARDS
   {
   movetype absolute

   entrycommands
      {
      startuseobject
      }

   legs
      {
      switch_backward_activate    : default
      }

   states
      {
      KILLED                       : KILLED
      USESWITCH_STOP_BACKWARD      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Finishing manipulation of the lever in reverse
//
////////////////////////////////////////////////////////////////

state USESWITCH_STOP_BACKWARD
   {
   movetype absolute

   entrycommands
      {
      finishuseobject
      }

   legs
      {
      switch_backward_to_stand    : default
      }

   states
      {
      KILLED     : KILLED
      STAND      : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Player is about to become a fakeplayer
//
////////////////////////////////////////////////////////////////

state FAKEPLAYER
   {
   movetype fakeplayer

   states
      {
      STAND                   : !FAKEPLAYERACTIVE
      }
   }

////////////////////////////////////////////////////////////////
//
// Player just received a cool item
//
////////////////////////////////////////////////////////////////

state DO_COOL_ITEM
   {
   movetype legs

   entrycommands
      {
      safeholster 1
      }

   states
      {
      DO_COOL_ITEM_START      : !HAS_WEAPON
      STAND                   : default
      }
   }

state DO_COOL_ITEM_START
   {
   movetype anim

   entrycommands
      {
      startcoolitem
      }

  legs
      {
      got_cool_item       : default
      }

   states
      {
      KILLED              : KILLED
      DO_COOL_ITEM_STOP   : ANIMDONE_LEGS
      }
   exitcommands
      {
      stopcoolitem
      }
   }

state DO_COOL_ITEM_ANIM
   {
   movetype coolobject

   torso
      {
      //
      // the anim is started by the coolobject query itself.  When we
      // transition into this state we are already playing an animation
      //
      none        : default
      }

   states
      {
      KILLED               : KILLED
      DO_COOL_ITEM_STOP    : ANIMDONE_LEGS
      }
   exitcommands
      {
      stopcoolitem
      }
   }

state DO_COOL_ITEM_STOP
   {
   entrycommands
      {
      safeholster 0
      }
   states
      {
      STAND               : default
      }
   }



////////////////////////////////////////////////////////////////
//
// Vehicle Code
//
////////////////////////////////////////////////////////////////

state VEHICLE_IDLE
   {
   movetype anim

   legs
      {
      crouch_idle : default
      }

   states
      {
      KILLED               : KILLED
      VEHICLE_USE          : USE
      }
   }

state VEHICLE_USE
   {
   movetype anim

   legs
      {
      crouch_idle : default
      }

   states
      {
      KILLED               : KILLED
      STAND                : -USE
      }

   exitcommands
      {
      usestuff // this allows us to get out of the vehicle
      }

   }

////////////////////////////////////////////////////////////////
//
// Pickup
//
////////////////////////////////////////////////////////////////

state PICKUP_SHGLIEK
   {
   movetype pickupenemy

   legs
      {
      shgliek_pickup : default
      }

   states
      {
      KILLED         : KILLED
      STAND          : HAS_WEAPON
      STAND      : ANIMDONE_LEGS !HAVE_SHGLIEK
      PICKUP_STAND   : ANIMDONE_LEGS
      }
   }

state PICKUP_STAND
   {
   movetype anim

   legs
      {
      stand_with_shgliek  : default
      }

   states
      {
      KILLED               : KILLED
      PICKUP_THROW         : FAKEPLAYERACTIVE
      PICKUP_WALK_FORWARD  : FORWARD !BACKWARD !CAN_FALL
      PICKUP_STRAFE_RIGHT  : STRAFE_RIGHT !BACKWARD !FORWARD CAN_MOVE_RIGHT !BLOCKED "2" !CAN_FALL
      PICKUP_STRAFE_LEFT   : STRAFE_LEFT  !BACKWARD !FORWARD CAN_MOVE_LEFT  !BLOCKED "2" !CAN_FALL

      PICKUP_WALK_BACKWARD : BACKWARD !FORWARD CAN_MOVE_BACKWARD

      PICKUP_THROW         : USE
      PICKUP_THROW         : ATTACKLEFTBUTTON
      PICKUP_THROW         : ATTACKRIGHTBUTTON
      PICKUP_THROW         : NEW_WEAPON
      PICKUP_THROW         : SHGLIEK_DEAD
      }
   }

state PICKUP_THROW
   {
   movetype anim

   legs
      {
      shgliek_throw  : default
      }

   states
      {
      KILLED                    : KILLED
      STAND       : ANIMDONE_LEGS
      }

   exitcommands
      {
      // bring back our previous weapons
      safeholster 0
      }
   }

state PICKUP_WALK_FORWARD
   {
   movetype user

   legs
      {
      shgliek_hold_walking : default
      }

   states
      {
      KILLED                       : KILLED

      PICKUP_STAND                 : CAN_FALL
      PICKUP_STAND                 : !FORWARD !STRAFE_LEFT !STRAFE_RIGHT

      PICKUP_STRAFE_RIGHT  : STRAFE_RIGHT !BACKWARD !FORWARD CAN_MOVE_RIGHT !BLOCKED "2"
      PICKUP_STRAFE_LEFT   : STRAFE_LEFT  !BACKWARD !FORWARD CAN_MOVE_LEFT  !BLOCKED "2"


      PICKUP_THROW         : FAKEPLAYERACTIVE
      PICKUP_THROW         : USE
      PICKUP_THROW         : ATTACKLEFTBUTTON
      PICKUP_THROW         : ATTACKRIGHTBUTTON
      PICKUP_THROW         : NEW_WEAPON
      PICKUP_THROW         : SHGLIEK_DEAD
      }
   }

state PICKUP_WALK_BACKWARD
   {
   movetype user

   legs
      {
      shgliek_hold_walking_back   : default
      }

   states
      {
      KILLED                      : KILLED

      PICKUP_STAND                : !BACKWARD
      PICKUP_STAND                : !CAN_MOVE_BACKWARD

      PICKUP_STRAFE_RIGHT  : STRAFE_RIGHT !BACKWARD !FORWARD CAN_MOVE_RIGHT !BLOCKED "2"
      PICKUP_STRAFE_LEFT   : STRAFE_LEFT  !BACKWARD !FORWARD CAN_MOVE_LEFT  !BLOCKED "2"

      PICKUP_THROW         : FAKEPLAYERACTIVE
      PICKUP_THROW         : USE
      PICKUP_THROW         : ATTACKLEFTBUTTON
      PICKUP_THROW         : ATTACKRIGHTBUTTON
      PICKUP_THROW         : NEW_WEAPON
      PICKUP_THROW         : SHGLIEK_DEAD
      }
   }

state PICKUP_STRAFE_LEFT
   {
   movetype user

   legs
      {
      walk_strafe_left      : default
      }

   states
      {
      KILLED               : KILLED

      PICKUP_STAND         : CAN_FALL
      PICKUP_STAND         : BLOCKED "2"
      PICKUP_STAND         : !STRAFE_LEFT
      PICKUP_STAND         : STRAFE_RIGHT
      PICKUP_STAND         : FORWARD
      PICKUP_STAND         : BACKWARD


      PICKUP_THROW         : FAKEPLAYERACTIVE
      PICKUP_THROW         : USE
      PICKUP_THROW         : ATTACKLEFTBUTTON
      PICKUP_THROW         : ATTACKRIGHTBUTTON
      PICKUP_THROW         : NEW_WEAPON
      PICKUP_THROW         : SHGLIEK_DEAD
      }
   }

state PICKUP_STRAFE_RIGHT
   {
   movetype user

   legs
      {
      walk_strafe_right    : default
      }

   states
      {
      KILLED               : KILLED

      PICKUP_STAND         : CAN_FALL
      PICKUP_STAND         : BLOCKED "2"
      PICKUP_STAND         : STRAFE_LEFT
      PICKUP_STAND         : !STRAFE_RIGHT
      PICKUP_STAND         : FORWARD
      PICKUP_STAND         : BACKWARD

      PICKUP_THROW         : FAKEPLAYERACTIVE
      PICKUP_THROW         : USE
      PICKUP_THROW         : ATTACKLEFTBUTTON
      PICKUP_THROW         : ATTACKRIGHTBUTTON
      PICKUP_THROW         : NEW_WEAPON
      PICKUP_THROW         : SHGLIEK_DEAD
      }
   }

////////////////////////////////////////////////////////////////
//
// Attacks
//
////////////////////////////////////////////////////////////////

state AIM
   {
   movetype legs

   torso
      {
      both_aim                  : TARGET_ACQUIRED "both"
      right_aim                 : TARGET_ACQUIRED "right"
      left_aim                  : TARGET_ACQUIRED "left"
      }
   states
      {
      KILLED_FROM_FRONT         : KILLED PAIN_DIRECTION "Front"
      KILLED                    : KILLED
      START_CHARGE_ATTACK_LEFT  : ATTACKLEFT IS_WEAPON_READY_TO_FIRE  "lefthand"    "Sling"
      START_CHARGE_ATTACK_LEFT  : ATTACKLEFT IS_WEAPON_READY_TO_FIRE  "lefthand"    "Crossbow"
      START_CHARGE_ATTACK_RIGHT : ATTACKRIGHT IS_WEAPON_READY_TO_FIRE "righthand"   "Crossbow"
      ATTACK_BOTH_UZI           : ATTACKLEFT ATTACKRIGHT IS_WEAPON_ACTIVE "lefthand" "Uzi" IS_WEAPON_ACTIVE "righthand" "DualUzi" ANIMDONE_TORSO
      CHECK_ATTACK_LEFT_NOAIM   : ATTACKLEFT
      CHECK_ATTACK_RIGHT_NOAIM  : ATTACKRIGHT
      STAND                     : ANIMDONE_TORSO
      }
   }

state ATTACK_DUAL_PRIMARY_ANIMDRIVEN
   {
   movetype anim

   legs
      {
      plant_fuse_on_floor_left   : IS_WEAPON_ACTIVE "lefthand"  "Flashbang"
      plant_fuse_on_floor_right  : IS_WEAPON_ACTIVE "righthand" "Flashbang"
      none                       : default
      }
   states
      {
      KILLED_FROM_FRONT             : KILLED PAIN_DIRECTION "Front"
      KILLED                        : KILLED
      RELOAD_FLASHBANG              : ANIMDONE_LEGS
      }
   }

state RELOAD_FLASHBANG
   {
   movetype legs

   torso
      {
      reload_flashbang_left  : IS_WEAPON_ACTIVE "lefthand" "Flashbang"
      reload_flashbang_right : IS_WEAPON_ACTIVE "righthand" "Flashbang"
      }
   states
      {
      PUTAWAY_LEFT      : PUTAWAYLEFT
      PUTAWAY_RIGHT     : PUTAWAYRIGHT
      KILLED_FROM_FRONT : KILLED PAIN_DIRECTION "Front"
      KILLED            : KILLED
      STAND             : ANIMDONE_TORSO
      }
   }

state ATTACK_DUAL_PRIMARY
   {
   movetype legs

   torso
      {
      stand_primary_fire_shotgun    : IS_WEAPON_ACTIVE "dualhand" "Shotgun"
      stand_primary_fire_flame      : IS_WEAPON_ACTIVE "dualhand" "Flamethrower"
      stand_primary_fire_soulsucker : IS_WEAPON_ACTIVE "dualhand" "Soulsucker"
      stand_primary_fire_horn       : IS_WEAPON_ACTIVE "dualhand" "Horn_Of_Conjuring"
      stand_primary_fire_rlauncher  : IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      none                          : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      RELOAD_DUAL_WEAPON : ANIMDONE_TORSO IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      RELOAD_DUAL_WEAPON : ANIMDONE_TORSO IS_WEAPON_ACTIVE "dualhand" "Shotgun"
      STAND              : !HAS_AMMO "dualhand" "primary"
      STAND              : ANIMDONE_TORSO !ATTACKLEFT
      }
   }

state RELOAD_DUAL_WEAPON
   {
   movetype legs

   torso
      {
      reload_rlauncher       : IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      primary_reload_shotgun : IS_WEAPON_ACTIVE "dualhand" "Shotgun"
      }

   states
      {
      PAIN               : PAIN
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : ANIMDONE_TORSO
      }
   }

//===========================================================================
// Chaingun is special because of it's movetype and the ability to early exit
//===========================================================================
state ATTACK_DUAL_PRIMARY_CHAINGUN
   {
   movetype anim

   legs
      {
      stand_to_fire_chaingun : default
      }

   states
      {
      KILLED_FROM_FRONT     : KILLED PAIN_DIRECTION "Front"
      KILLED                : KILLED
      CHAINGUN_PRIMARY_FIRE : ANIMDONE_LEGS
      }
   }

state CHAINGUN_PRIMARY_FIRE
   {
   movetype anim

   legs
      {
      primary_fire_chaingun       : IS_WEAPON_ACTIVE "dualhand" "Chaingun"
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      EXIT_CHAINGUN_FIRE : !HAS_AMMO "dualhand" "primary"
      EXIT_CHAINGUN_FIRE : !ATTACKLEFT
      }

   exitcommands
      {
      stopfire dualhand
      }
   }

state ATTACK_DUAL_PRIMARY_SOULSUCKER
   {
   movetype legs

   torso
      {
      stand_to_fire_soulsucker : default
      }

   states
      {
      KILLED_FROM_FRONT       : KILLED PAIN_DIRECTION "Front"
      KILLED                  : KILLED
      SOULSUCKER_PRIMARY_FIRE : ANIMDONE_TORSO
      }
   }

state SOULSUCKER_PRIMARY_FIRE
   {
   movetype legs

   torso
      {
      stand_primary_fire_soulsucker : IS_WEAPON_ACTIVE "dualhand" "Soulsucker"
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : !ATTACKLEFT
      }

   exitcommands
      {
      stopfire dualhand
      }
   }

state EXIT_CHAINGUN_FIRE
   {
   movetype anim

   legs
      {
      //fire_chaingun_to_stand : default
      none : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : ANIMDONE_LEGS
      }
   }



state ATTACK_DUAL_ALTERNATE
   {
   movetype legs

   torso
      {
      stand_alternate_fire_shotgun      : IS_WEAPON_ACTIVE "dualhand" "Shotgun"
      stand_alternate_fire_soulsucker   : IS_WEAPON_ACTIVE "dualhand" "Soulsucker"
      stand_alternate_fire_rlauncher    : IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      stand_alternate_fire_flame        : IS_WEAPON_ACTIVE "dualhand" "Flamethrower"
      stand_primary_fire_horn           : IS_WEAPON_ACTIVE "dualhand" "Horn_Of_Conjuring"
      none                              : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      RELOAD_DUAL_WEAPON : ANIMDONE_TORSO IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      STAND              : !HAS_AMMO "dualhand" "alternate"
      STAND              : ANIMDONE_TORSO !ATTACKRIGHT
      }
   }

//=============================================
// Chaingun is special because of it's movetype
//=============================================
state ATTACK_DUAL_ALTERNATE_CHAINGUN
   {
   movetype anim

   legs
      {
      stand_to_fire_chaingun : default
      }
   states
      {
      KILLED_FROM_FRONT       : KILLED PAIN_DIRECTION "Front"
      KILLED                  : KILLED
      CHAINGUN_ALTERNATE_FIRE : ANIMDONE_LEGS
      }
   }

state CHAINGUN_ALTERNATE_FIRE
   {
   movetype anim

   legs
      {
      alternate_fire_chaingun       : IS_WEAPON_ACTIVE "dualhand" "Chaingun"
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      EXIT_CHAINGUN_FIRE : !HAS_AMMO "dualhand" "alternate"
      EXIT_CHAINGUN_FIRE : !ATTACKRIGHT
      }
   }

state ATTACK_DUAL_ALTERNATE_HOLD
   {
   movetype legs

   torso
      {
      stand_alternate_fire_chainsword : IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      none                            : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : !HAS_AMMO "dualhand" "alternate"
      STAND              : !ATTACKRIGHT
      }
   }

//======================================================
// Start charge attack with Dual Handed Weapons - Primary Mode
//======================================================
state START_CHARGE_ATTACK_DUAL_PRI
   {
   movetype legs

   torso
      {
      sling_charge              : IS_WEAPON_ACTIVE "dualhand" "Sling"
      sling_charge              : IS_WEAPON_ACTIVE "dualhand" "GasSling"
      sling_charge              : IS_WEAPON_ACTIVE "dualhand" "AsteroidSling"
      }
   states
      {
      RELEASE_ATTACK_DUAL_PRI   : KILLED
      RELEASE_ATTACK_DUAL_PRI   : PAIN
      RELEASE_ATTACK_DUAL_PRI   : !ATTACKRIGHT !ATTACKLEFT ANIMDONE_TORSO
      }
   }
//======================================================
// Release charge attack with Dual Handed Weapons - Primary Mode
//======================================================
state RELEASE_ATTACK_DUAL_PRI
   {
   movetype legs

   torso
      {
      sling_clear               : KILLED
      sling_fire_and_reload     : IS_WEAPON_ACTIVE "dualhand" "Sling"
      sling_fire_and_reload     : IS_WEAPON_ACTIVE "dualhand" "GasSling"
      sling_fire_and_reload     : IS_WEAPON_ACTIVE "dualhand" "AsteroidSling"
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front" ANIMDONE_TORSO
      KILLED             : KILLED ANIMDONE_TORSO
      STAND              : ANIMDONE_TORSO
      }
   }

//======================================================
// Start charge attack with Dual Handed Weapons - Alternate Mode
//======================================================
state START_CHARGE_ATTACK_DUAL_ALT
   {
   movetype legs

   torso
      {
      sling_charge              : IS_WEAPON_ACTIVE "dualhand" "Sling"
      sling_charge              : IS_WEAPON_ACTIVE "dualhand" "GasSling"
      sling_charge              : IS_WEAPON_ACTIVE "dualhand" "AsteroidSling"
      }
   states
      {
      RELEASE_ATTACK_DUAL_ALT   : KILLED
      RELEASE_ATTACK_DUAL_ALT   : PAIN
      RELEASE_ATTACK_DUAL_ALT   : !ATTACKRIGHT !ATTACKLEFT ANIMDONE_TORSO
      }
   }

//======================================================
// Release charge attack with Dual Handed Weapons - Alternate Mode
//======================================================
state RELEASE_ATTACK_DUAL_ALT
   {
   movetype legs

   torso
      {
      sling_clear               : KILLED
      sling_fire_and_reload     : IS_WEAPON_ACTIVE "dualhand" "Sling"
      sling_fire_and_reload     : IS_WEAPON_ACTIVE "dualhand" "GasSling"
      sling_fire_and_reload     : IS_WEAPON_ACTIVE "dualhand" "AsteroidSling"
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front" ANIMDONE_TORSO
      KILLED             : KILLED ANIMDONE_TORSO
      STAND              : ANIMDONE_TORSO
      }
   }

state START_CHARGE_ATTACK_LEFT
   {
   movetype legs

   torso
      {
      stand_left_crossbow_charge   : IS_WEAPON_ACTIVE "lefthand" "Crossbow"
      }
   states
      {
      RELEASE_ATTACK_LEFT       : KILLED
      RELEASE_ATTACK_LEFT       : PAIN
      RELEASE_ATTACK_LEFT       : !ATTACKLEFT
      }
   }

state RELEASE_ATTACK_LEFT
   {
   movetype legs

   torso
      {
      stand_left_fire_crossbow  : IS_WEAPON_ACTIVE "lefthand" "Crossbow"
      }
   states
      {
      STAND              : ANIMDONE_TORSO
      }
   }

state START_CHARGE_ATTACK_RIGHT
   {
   movetype legs

   torso
      {
      stand_right_crossbow_charge  : IS_WEAPON_ACTIVE "righthand" "Crossbow"
      }
   states
      {
      RELEASE_ATTACK_RIGHT       : KILLED
      RELEASE_ATTACK_RIGHT       : PAIN
      RELEASE_ATTACK_RIGHT       : !ATTACKRIGHT ANIMDONE_TORSO
      }
   }

state RELEASE_ATTACK_RIGHT
   {
   movetype legs

   torso
      {
      stand_right_fire_crossbow    : IS_WEAPON_ACTIVE "righthand" "Crossbow"
      }
   states
      {
      STAND              : ANIMDONE_TORSO
      }
   }

state CHECK_ATTACK_BOTH
   {
   movetype legs

   states
      {
      AIM_WEAPON_BOTH          : IS_WEAPON_READY_TO_FIRE "lefthand" "Uzi" IS_WEAPON_READY_TO_FIRE "righthand" "DualUzi"
      STAND                    : !ATTACKLEFT
      STAND                    : !ATTACKRIGHT
      }
   }

state AIM_WEAPON_BOTH
   {
   movetype legs

   torso
      {
      both_aim  : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      ATTACK_BOTH_UZI    : IS_WEAPON_ACTIVE "lefthand" "Uzi" IS_WEAPON_ACTIVE "righthand" "DualUzi" ANIMDONE_TORSO
      }
   }

state ATTACK_BOTH_UZI
   {
   movetype legs

   torso
      {
      stand_both_fire_uzi  : IS_WEAPON_ACTIVE "lefthand" "Uzi" IS_WEAPON_ACTIVE "righthand" "DualUzi"
      none                 : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      PAIN               : PAIN
      STAND              : ANIMDONE_TORSO !ATTACKLEFT
      STAND              : ANIMDONE_TORSO !ATTACKRIGHT
      }

   exitcommands
      {
      stopfire lefthand
      stopfire righthand
      }
   }

state CHECK_ATTACK_LEFT
   {
   movetype legs

   states
      {
      AIM_WEAPON_LEFT                : IS_WEAPON_READY_TO_FIRE     "lefthand" "Uzi"
      AIM_WEAPON_LEFT                : IS_WEAPON_READY_TO_FIRE     "lefthand" "HandGun"
      RAISE_LEFT_SHIELD              : IS_WEAPON_READY_TO_FIRE     "lefthand" "SmallShield"
      RAISE_LEFT_SHIELD_NOMOVE       : IS_WEAPON_READY_TO_FIRE     "lefthand" "LargeShield" ONGROUND !FALLING
      ATTACK_DUAL_PRIMARY_ANIMDRIVEN : IS_WEAPON_READY_TO_FIRE     "lefthand" "Flashbang" ONGROUND !FALLING
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Shotgun"
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Rocket_Launcher"
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Flamethrower"
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Horn_Of_Conjuring"
      ATTACK_DUAL_PRIMARY_CHAINGUN   : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Chaingun"
      ATTACK_DUAL_PRIMARY_SOULSUCKER : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Soulsucker"
      FALLING_AXE_ATTACK             : IS_DUALWEAPON_READY_TO_FIRE "primary"  "ChainSword" !ONGROUND
      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "primary"  "ChainSword"
      AXE_ATTACK                     : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Axe" STRAFE_LEFT
      AXE_ATTACK                     : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Axe" STRAFE_RIGHT
      FALLING_AXE_ATTACK             : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Axe" !ONGROUND
      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "primary"  "Axe" ONGROUND
      FALLING_AXE_ATTACK             : IS_DUALWEAPON_READY_TO_FIRE "primary"  "LightSword" !ONGROUND
      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "primary"  "LightSword" ONGROUND
      STAND                          : !ATTACKLEFT
      }
   }

state CHECK_ATTACK_LEFT_NOAIM
   {
   movetype legs

   states
      {
      ATTACK_LEFT_UZI                : IS_WEAPON_READY_TO_FIRE "lefthand" "Uzi"
      ATTACK_LEFT                    : IS_WEAPON_READY_TO_FIRE "lefthand" "HandGun"
      RAISE_LEFT_SHIELD              : IS_WEAPON_READY_TO_FIRE "lefthand" "SmallShield"
      RAISE_LEFT_SHIELD_NOMOVE       : IS_WEAPON_READY_TO_FIRE "lefthand" "LargeShield" ONGROUND !FALLING
      ATTACK_DUAL_PRIMARY_ANIMDRIVEN : IS_DUALWEAPON_READY_TO_FIRE "primary" "Flashbang" ONGROUND !FALLING
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary" "Shotgun"
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary" "Rocket_Launcher"
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary" "Flamethrower"
      ATTACK_DUAL_PRIMARY            : IS_DUALWEAPON_READY_TO_FIRE "primary" "Horn_Of_Conjuring"
      ATTACK_DUAL_PRIMARY_CHAINGUN   : IS_DUALWEAPON_READY_TO_FIRE "primary" "Chaingun"
      ATTACK_DUAL_PRIMARY_SOULSUCKER : IS_DUALWEAPON_READY_TO_FIRE "primary" "Soulsucker"
      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "primary" "ChainSword"
      AXE_ATTACK                     : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe" STRAFE_LEFT
      AXE_ATTACK                     : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe" STRAFE_RIGHT
      FALLING_AXE_ATTACK             : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe" !ONGROUND
      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe" ONGROUND
      FALLING_AXE_ATTACK             : IS_DUALWEAPON_READY_TO_FIRE "primary" "LightSword" !ONGROUND
      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "primary" "LightSword" ONGROUND
      STAND                          : !ATTACKLEFT
      }
   }

// This state is called before firing, so the player has time to raise the weapon
// and it doesn't fire before then.
state AIM_WEAPON_LEFT
   {
   movetype legs

   torso
      {
      raise_left_aim  : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      ATTACK_LEFT_UZI    : IS_WEAPON_ACTIVE "lefthand" "Uzi"     ANIMDONE_TORSO
      ATTACK_LEFT        : IS_WEAPON_ACTIVE "lefthand" "HandGun" ANIMDONE_TORSO
      }
   }

state ATTACK_LEFT_UZI
   {
   movetype legs

   torso
      {
      stand_left_fire_uzi : IS_WEAPON_ACTIVE "lefthand" "Uzi"
      none                : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      PAIN               : PAIN
      ATTACK_BOTH_UZI    : ATTACKLEFT ATTACKRIGHT IS_WEAPON_ACTIVE "lefthand" "Uzi" IS_WEAPON_ACTIVE "righthand" "DualUzi" ANIMDONE_TORSO
      STAND              : !HAS_AMMO "lefthand" "primary"
      STAND              : ANIMDONE_TORSO !ATTACKLEFT
      }

   exitcommands
      {
      stopfire lefthand
      }
   }

state ATTACK_LEFT
   {
   movetype legs

   torso
      {
      stand_left_fire_handgun : IS_WEAPON_ACTIVE "lefthand" "HandGun"
      stand_left_fire_uzi     : IS_WEAPON_ACTIVE "lefthand" "Uzi"
      null                    : IS_WEAPON_ACTIVE "Error"
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      PAIN               : PAIN
      STAND              : !HAS_AMMO "lefthand" "primary"
      STAND              : ANIMDONE_TORSO !ATTACKLEFT
      }
   }

state RAISE_LEFT_SHIELD
   {
   movetype legs

   torso
      {
      left_smallshield_block  : IS_WEAPON_ACTIVE "lefthand" "SmallShield"
      left_shield_block       : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      LEFT_SHIELD_HOLD   : ANIMDONE_TORSO ATTACKLEFTBUTTON
      STAND              : ANIMDONE_TORSO
      }
   }

state LEFT_SHIELD_HOLD
   {
   movetype legs

   entrycommands
      {
      activateshield
      }
   torso
      {
//      left_smallshield_hold_block_long  : IS_WEAPON_ACTIVE "lefthand" "SmallShield"
      left_smallshield_hold_block       : IS_WEAPON_ACTIVE "lefthand" "SmallShield"
      left_shield_holdblock             : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      PAIN               : PAIN
      STAND              : ANIMDONE_TORSO !ATTACKLEFTBUTTON
      }
   exitcommands
      {
      deactivateshield
      }
   }

state RAISE_LEFT_SHIELD_NOMOVE
   {
   movetype anim

   legs
      {
      left_shield_block : default
      }

   states
      {
      KILLED_FROM_FRONT       : KILLED PAIN_DIRECTION "Front"
      KILLED                  : KILLED
      LEFT_SHIELD_HOLD_NOMOVE : ANIMDONE_LEGS
      }
   }

state LEFT_SHIELD_HOLD_NOMOVE
   {
   movetype anim

   entrycommands
      {
      activateshield
      }
   legs
      {
      left_shield_holdblock : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      PAIN               : PAIN
      STAND              : ANIMDONE_LEGS !ATTACKLEFTBUTTON
      }
   exitcommands
      {
      deactivateshield
      }
   }

state CHECK_ATTACK_RIGHT
   {
   movetype legs

   torso
      {
      stand_dual_hold_shotgun       : IS_WEAPON_ACTIVE "dualhand" "Shotgun"
      stand_dual_hold_chaingun      : IS_WEAPON_ACTIVE "dualhand" "Chaingun"
      stand_dual_hold_rlauncher     : IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      stand_dual_hold_soulsucker    : IS_WEAPON_ACTIVE "dualhand" "Soulsucker"
      stand_dual_hold_flamethrower  : IS_WEAPON_ACTIVE "dualhand" "Flamethrower"
      dual_hold_sword               : IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      dual_hold_sword               : IS_WEAPON_ACTIVE "dualhand" "Axe"
      dual_hold_sword               : IS_WEAPON_ACTIVE "dualhand" "LightSword"
      }

   states
      {
      AIM_WEAPON_RIGHT               : IS_WEAPON_READY_TO_FIRE     "righthand" "Uzi"
      AIM_WEAPON_RIGHT               : IS_WEAPON_READY_TO_FIRE     "righthand" "DualUzi"
      AIM_WEAPON_RIGHT               : IS_WEAPON_READY_TO_FIRE     "righthand" "HandGun"
      ATTACK_DUAL_PRIMARY_ANIMDRIVEN : IS_WEAPON_READY_TO_FIRE     "righthand" "Flashbang" ONGROUND !FALLING
      ATTACK_DUAL_ALTERNATE          : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Shotgun"
      ATTACK_DUAL_ALTERNATE          : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Soulsucker"
      ATTACK_DUAL_ALTERNATE_HOLD     : IS_DUALWEAPON_READY_TO_FIRE "alternate" "ChainSword"
      ATTACK_DUAL_ALTERNATE_CHAINGUN : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Chaingun"
      ATTACK_DUAL_ALTERNATE          : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Flamethrower"
      ATTACK_DUAL_ALTERNATE          : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Rocket_Launcher"
      ATTACK_DUAL_ALTERNATE          : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Horn_Of_Conjuring"
      SWORD_ATTACK_PRE1              : IS_WEAPON_READY_TO_FIRE     "righthand" "GreenSword" !ATTACKLEFTBUTTON
      SWORD_ATTACK_PRE1              : IS_WEAPON_READY_TO_FIRE     "righthand" "FireSword"  !ATTACKLEFTBUTTON
      SWORD_ATTACK_PRE1              : IS_WEAPON_READY_TO_FIRE     "righthand" "ElecSword"  !ATTACKLEFTBUTTON


      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "alternate" "LightSword" ONGROUND
      FALLING_AXE_ATTACK             : IS_DUALWEAPON_READY_TO_FIRE "alternate" "LightSword" !ONGROUND
      AXE_ATTACK                     : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Axe" STRAFE_LEFT
      AXE_ATTACK                     : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Axe" STRAFE_RIGHT
      FALLING_AXE_ATTACK             : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Axe" !ONGROUND
      OTHER_COMBO_ATTACK1            : IS_DUALWEAPON_READY_TO_FIRE "alternate" "Axe"

      STAND                            : !ATTACKRIGHT
      }
   }

state CHECK_ATTACK_RIGHT_NOAIM
   {
   movetype legs

   states
      {
      ATTACK_RIGHT_UZI                 : IS_WEAPON_READY_TO_FIRE "righthand" "Uzi"
      ATTACK_RIGHT_UZI                 : IS_WEAPON_READY_TO_FIRE "righthand" "DualUzi"
      ATTACK_RIGHT                     : IS_WEAPON_READY_TO_FIRE "righthand" "HandGun"
      ATTACK_DUAL_ALTERNATE            : IS_DUALWEAPON_READY_TO_FIRE "alternate"  "Shotgun"
      ATTACK_DUAL_ALTERNATE            : IS_DUALWEAPON_READY_TO_FIRE "alternate"  "Soulsucker"
      ATTACK_DUAL_ALTERNATE_HOLD       : IS_DUALWEAPON_READY_TO_FIRE "alternate"  "ChainSword"
      ATTACK_DUAL_ALTERNATE_CHAINGUN   : IS_DUALWEAPON_READY_TO_FIRE "alternate"  "Chaingun"
      SWORD_ATTACK_PRE1                : IS_WEAPON_READY_TO_FIRE "righthand" "GreenSword" !ATTACKLEFTBUTTON
      SWORD_ATTACK_PRE1                : IS_WEAPON_READY_TO_FIRE "righthand" "FireSword"  !ATTACKLEFTBUTTON
      SWORD_ATTACK_PRE1                : IS_WEAPON_READY_TO_FIRE "righthand" "ElecSword"  !ATTACKLEFTBUTTON

      // Primary fire for right attack for these weapons
      ATTACK_DUAL_PRIMARY              : IS_DUALWEAPON_READY_TO_FIRE "primary" "Rocket_Launcher"
      ATTACK_DUAL_PRIMARY              : IS_DUALWEAPON_READY_TO_FIRE "primary" "Horn_Of_Conjuring"

      OTHER_COMBO_ATTACK1              : IS_DUALWEAPON_READY_TO_FIRE "primary" "LightSword"
      AXE_ATTACK                       : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe" STRAFE_LEFT
      AXE_ATTACK                       : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe" STRAFE_RIGHT
      FALLING_AXE_ATTACK               : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe" !ONGROUND
      OTHER_COMBO_ATTACK1              : IS_DUALWEAPON_READY_TO_FIRE "primary" "Axe"

      STAND                            : !ATTACKRIGHT
      }
   }

// This state is called before firing, so the player has time to raise the weapon
// and it doesn't fire before then.
state AIM_WEAPON_RIGHT
   {
   movetype legs

   torso
      {
      raise_right_aim  : default
      }
   states
      {
      KILLED_FROM_FRONT : KILLED PAIN_DIRECTION "Front"
      KILLED            : KILLED
      ATTACK_RIGHT_UZI  : IS_WEAPON_ACTIVE "righthand" "Uzi"     ANIMDONE_TORSO
      ATTACK_RIGHT_UZI  : IS_WEAPON_ACTIVE "righthand" "DualUzi" ANIMDONE_TORSO
      ATTACK_RIGHT      : IS_WEAPON_ACTIVE "righthand" "HandGun" ANIMDONE_TORSO
      }
   }

state ATTACK_RIGHT_UZI
   {
   movetype legs

   torso
      {
      stand_right_fire_uzi : IS_WEAPON_ACTIVE "righthand" "Uzi"
      stand_right_fire_uzi : IS_WEAPON_ACTIVE "righthand" "DualUzi"
      none                 : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      PAIN               : PAIN
      ATTACK_BOTH_UZI    : ATTACKLEFT ATTACKRIGHT IS_WEAPON_ACTIVE "lefthand" "Uzi" IS_WEAPON_ACTIVE "righthand" "DualUzi" ANIMDONE_TORSO
      STAND              : !HAS_AMMO "righthand" "primary"
      STAND              : ANIMDONE_TORSO !ATTACKRIGHT
      }

   exitcommands
      {
      stopfire righthand
      }
   }

state ATTACK_RIGHT
   {
   movetype legs

   torso
      {
      stand_right_fire_handgun : IS_WEAPON_ACTIVE "righthand" "HandGun"
      null                     : IS_WEAPON_ACTIVE "Error"
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      PAIN               : PAIN
      STAND              : !HAS_AMMO "righthand" "primary"
      STAND              : ANIMDONE_TORSO !ATTACKRIGHT
      }
   }

//======================================================================
// PUTAWAY
//======================================================================

state PUTAWAY_LEFT
   {
   movetype legs

   torso
      {
      lower_left_to_holster   : IS_WEAPON_ACTIVE "lefthand" "Crossbow"
      lower_left_to_lowerback : IS_WEAPON_ACTIVE "lefthand" "Uzi"
      lower_left_to_lowerback : IS_WEAPON_ACTIVE "lefthand" "DualUzi"
      lower_left_to_lowerback : IS_WEAPON_ACTIVE "lefthand" "HandGun"
      lower_left_to_holster   : IS_WEAPON_ACTIVE "lefthand" "SmallShield"
      lower_left_to_holster   : IS_WEAPON_ACTIVE "lefthand" "LargeShield"
      lower_sword_left        : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : ANIMDONE_TORSO
      }
   }

state PUTAWAY_RIGHT
   {
   movetype legs

   torso
      {
      lower_right_to_holster   : IS_WEAPON_ACTIVE "righthand" "Crossbow"
      lower_right_to_lowerback : IS_WEAPON_ACTIVE "righthand" "Uzi"
      lower_right_to_lowerback : IS_WEAPON_ACTIVE "righthand" "DualUzi"
      lower_right_to_lowerback : IS_WEAPON_ACTIVE "righthand" "HandGun"
      lower_sword_right        : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : ANIMDONE_TORSO
      }
   }

state PUTAWAY_DUAL
   {
   movetype legs

   torso
      {
      putaway_shotgun        : IS_WEAPON_ACTIVE "dualhand" "Shotgun"
      putaway_shotgun        : IS_WEAPON_ACTIVE "dualhand" "Rocket_Launcher"
      putaway_shotgun        : IS_WEAPON_ACTIVE "dualhand" "Flamethrower"
      putaway_shotgun        : IS_WEAPON_ACTIVE "dualhand" "Soulsucker"
      putaway_shotgun        : IS_WEAPON_ACTIVE "dualhand" "Horn_Of_Conjuring"

      lower_chainsword       : IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      lower_chainsword       : IS_WEAPON_ACTIVE "dualhand" "Axe"
      lower_chainsword       : IS_WEAPON_ACTIVE "dualhand" "LightSword"
      lower_2handed          : default
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : ANIMDONE_TORSO
      }
   }

//======================================================================
// RAISE_WEAPON
//======================================================================

state RAISE_WEAPON
   {
   movetype legs

   torso
      {
      raise_left_from_holster    : IS_NEW_WEAPON "lefthand"  "Crossbow"
      raise_right_from_holster   : IS_NEW_WEAPON "righthand" "Crossbow"
      raise_left_from_lowerback  : IS_NEW_WEAPON "lefthand"  "Uzi"
      raise_right_from_lowerback : IS_NEW_WEAPON "righthand" "Uzi"
      raise_left_from_lowerback  : IS_NEW_WEAPON "lefthand"  "DualUzi"
      raise_right_from_lowerback : IS_NEW_WEAPON "righthand" "DualUzi"
      raise_left_from_lowerback  : IS_NEW_WEAPON "lefthand"  "HandGun"
      raise_right_from_lowerback : IS_NEW_WEAPON "righthand" "HandGun"
      raise_right_from_holster   : IS_NEW_WEAPON "righthand" "Flashbang"
      raise_left_from_holster    : IS_NEW_WEAPON "lefthand"  "Flashbang"
      raise_sword_right          : IS_NEW_WEAPON "righthand" "GreenSword"
      raise_sword_right          : IS_NEW_WEAPON "righthand" "FireSword"
      raise_sword_right          : IS_NEW_WEAPON "righthand" "ElecSword"
      raise_chainsword           : IS_NEW_WEAPON "dualhand"  "ChainSword"
      raise_left_from_holster    : IS_NEW_WEAPON "lefthand"  "SmallShield"
      raise_left_from_holster    : IS_NEW_WEAPON "lefthand"  "LargeShield"
      raise_sword_right          : IS_NEW_WEAPON "dualhand"  "Sling"
      raise_sword_right          : IS_NEW_WEAPON "dualhand"  "GasSling"
      raise_sword_right          : IS_NEW_WEAPON "dualhand"  "AsteroidSling"
      raise_shotgun              : IS_NEW_WEAPON "dualhand"  "Shotgun"
      raise_shotgun              : IS_NEW_WEAPON "dualhand"  "Rocket_Launcher"
      raise_shotgun              : IS_NEW_WEAPON "dualhand"  "Flamethrower"
      raise_shotgun              : IS_NEW_WEAPON "dualhand"  "Soulsucker"
      raise_shotgun              : IS_NEW_WEAPON "dualhand"  "Horn_Of_Conjuring"
      raise_shotgun              : IS_NEW_WEAPON "dualhand"  "Chaingun"
      raise_sword_dual           : IS_NEW_WEAPON "dualhand"  "Axe"
      raise_sword_dual           : IS_NEW_WEAPON "dualhand"  "LightSword"
      null                       : IS_NEW_WEAPON "ERROR"
      }

   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : ANIMDONE_TORSO
      }
   }

//======================================================================
// ATTACKS GETTING BLOCKED
//======================================================================
state EXIT_BLOCKED
   {
   movetype legs

   torso
      {
      enemy_block_1_exit : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      STAND              : ANIMDONE_TORSO
      }
   }

state ATTACK_BLOCKED
   {
   movetype legs

   torso
      {
      enemy_block_1_hold : default
      }
   states
      {
      KILLED_FROM_FRONT  : KILLED PAIN_DIRECTION "Front"
      KILLED             : KILLED
      EXIT_BLOCKED       : ANIMDONE_TORSO BLOCK_DELAY "0.6"
      }
   }

//======================================================================
// SWORD COMBOS
//======================================================================

state SWORD_ATTACK_PRE1
   {
   movetype legs

   torso
      {
      // Strafing attacks
      null_sword_strafe_right_attack_1 : IS_WEAPON_ACTIVE "righthand" "GreenSword" STRAFE_RIGHT
      null_sword_strafe_left_attack_1  : IS_WEAPON_ACTIVE "righthand" "GreenSword" STRAFE_LEFT
      null_greensword_attack_1         : IS_WEAPON_ACTIVE "righthand" "GreenSword"
      null_greensword_attack_1         : IS_WEAPON_ACTIVE "righthand" "FireSword"
      null_greensword_attack_1         : IS_WEAPON_ACTIVE "righthand" "ElecSword"
      none                             : default
      }

   states
      {
      KILLED_FROM_FRONT : KILLED PAIN_DIRECTION "Front"
      KILLED            : KILLED
      PAIN              : PAIN
      ATTACK_BLOCKED    : ATTACK_BLOCKED
      STAND             : ANIMDONE_TORSO STRAFE_RIGHT
      STAND             : ANIMDONE_TORSO STRAFE_LEFT
      SWORD_ATTACK_PRE2 : ANIMDONE_TORSO ATTACKRIGHTBUTTON !ATTACKLEFTBUTTON
      STAND             : ANIMDONE_TORSO
      }
   }

state SWORD_ATTACK_PRE2
   {
   movetype legs

   torso
      {
      null_greensword_attack_2 : IS_WEAPON_ACTIVE "righthand" "GreenSword"
      null_greensword_attack_2 : IS_WEAPON_ACTIVE "righthand" "FireSword"
      null_greensword_attack_2 : IS_WEAPON_ACTIVE "righthand" "ElecSword"
      none                     : default
      }

   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      PAIN                : PAIN
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      SWORD_COMBO_ATTACK1 : ANIMDONE_TORSO ATTACKLEFTBUTTON
      SWORD_ATTACK_PRE2_PAUSE : ANIMDONE_TORSO
      }
   }

state SWORD_ATTACK_PRE2_PAUSE
   {
   movetype legs

   torso
      {
      null_greensword_attack_2_pause : IS_WEAPON_ACTIVE "righthand" "GreenSword"
      null_greensword_attack_2_pause : IS_WEAPON_ACTIVE "righthand" "FireSword"
      null_greensword_attack_2_pause : IS_WEAPON_ACTIVE "righthand" "ElecSword"
      none                           : default
      }

   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      PAIN                : PAIN
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      STAND               : ANIMDONE_TORSO
      }
   }

state SWORD_COMBO_ATTACK1
   {
   entrycommands
      {
      damage_multiplier 1.25
      }

   movetype anim

   legs
      {
      smallshield_greensword_attack_1 : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "GreenSword"
      smallshield_firesword_attack_1  : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "FireSword"
      smallshield_firesword_attack_1  : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "ElecSword"
      projectile_greensword_attack_1  : !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" !IS_WEAPON_ACTIVE "lefthand" "Flashbang" ANY_WEAPON_ACTIVE "lefthand" IS_WEAPON_ACTIVE "righthand" "GreenSword"
      projectile_firesword_attack_1   : !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" !IS_WEAPON_ACTIVE "lefthand" "Flashbang" ANY_WEAPON_ACTIVE "lefthand" IS_WEAPON_ACTIVE "righthand" "FireSword"
      projectile_elecsword_attack_1   : !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" !IS_WEAPON_ACTIVE "lefthand" "Flashbang" ANY_WEAPON_ACTIVE "lefthand" IS_WEAPON_ACTIVE "righthand" "ElecSword"
      null_greensword_attack_1        : IS_WEAPON_ACTIVE  "righthand" "GreenSword"
      null_firesword_attack_1         : IS_WEAPON_ACTIVE  "righthand" "FireSword"
      null_elecsword_attack_1         : IS_WEAPON_ACTIVE  "righthand" "ElecSword"
      dual_axe_attack_1               : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      none                            : default
      }

   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      SWORD_COMBO_ATTACK2 : ANIMDONE_LEGS ATTACKLEFTBUTTON // Left attack button only
      STAND               : ANIMDONE_LEGS
      STAND                : FALLING
      }

   exitcommands
      {
      damage_multiplier 1.0
      }
   }

state SWORD_COMBO_ATTACK2
   {
   entrycommands
      {
      damage_multiplier 1.25
      }

   movetype anim

   legs
      {
      smallshield_greensword_attack_2    : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "GreenSword"
      smallshield_firesword_attack_2     : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "FireSword"
      smallshield_firesword_attack_2     : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "ElecSword"
      projectile_greensword_attack_arm_2 : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "GreenSword" HAS_ARMORPIECE "Arm"
      projectile_greensword_attack_2     : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "GreenSword"
      projectile_firesword_attack_2      : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "FireSword"
      projectile_elecsword_attack_2      : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "ElecSword"
      null_greensword_attack_2           : IS_WEAPON_ACTIVE  "righthand" "GreenSword"
      null_firesword_attack_2            : IS_WEAPON_ACTIVE  "righthand" "FireSword"
      null_elecsword_attack_2            : IS_WEAPON_ACTIVE  "righthand" "ElecSword"
      dual_axe_attack_2                  : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      none                               : default
      }

   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      SWORD_COMBO_ATTACK3 : ANIMDONE_LEGS ATTACKLEFTBUTTON // Left attack button only
      STAND               : ANIMDONE_LEGS
      STAND               : FALLING
      }

   exitcommands
      {
      damage_multiplier 1.0
      }
   }

state SWORD_COMBO_ATTACK3
   {
   entrycommands
      {
      damage_multiplier 1.5
      }

   movetype anim

   legs
      {
      smallshield_greensword_attack_leg_3 : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "GreenSword" HAS_ARMORPIECE "Arm"
      smallshield_greensword_attack_3     : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "GreenSword"
      smallshield_firesword_attack_3      : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "FireSword"
      smallshield_firesword_attack_3      : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "ElecSword"
      projectile_greensword_attack_3      : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "GreenSword"
      projectile_firesword_attack_3       : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "FireSword"
      projectile_elecsword_attack_3       : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "ElecSword"
      null_greensword_attack_3            : IS_WEAPON_ACTIVE  "righthand" "GreenSword"
      null_firesword_attack_3             : IS_WEAPON_ACTIVE  "righthand" "FireSword"
      null_elecsword_attack_knee_3        : IS_WEAPON_ACTIVE  "righthand" "ElecSword" HAS_ARMORPIECE "Knee"
      null_elecsword_attack_3             : IS_WEAPON_ACTIVE  "righthand" "ElecSword"
      dual_axe_attack_3                   : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      none                                : default
      }

   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      SWORD_COMBO_ATTACK4 : ANIMDONE_LEGS ATTACKLEFTBUTTON
      STAND               : ANIMDONE_LEGS
      STAND               : FALLING
      }

   exitcommands
      {
      damage_multiplier 1.0
      }
   }

state SWORD_COMBO_ATTACK4
   {
   entrycommands
      {
      damage_multiplier 1.5
      }

   movetype anim

   legs
      {
      smallshield_greensword_attack_4          : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "GreenSword"
      smallshield_firesword_attack_shoulder_4  : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "FireSword" HAS_ARMORPIECE "Shoulder"
      smallshield_firesword_attack_4           : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "FireSword"
      smallshield_firesword_attack_4           : IS_WEAPON_ACTIVE  "lefthand"  "SmallShield" IS_WEAPON_ACTIVE "righthand" "ElecSword"
      projectile_greensword_attack_4           : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "GreenSword"
      projectile_firesword_attack_4            : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "FireSword"
      projectile_elecsword_attack_4            : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand"  IS_WEAPON_ACTIVE "righthand" "ElecSword"
      null_greensword_attack_knee_4            : IS_WEAPON_ACTIVE  "righthand" "GreenSword"       HAS_ARMORPIECE "Knee"
      null_greensword_attack_4                 : IS_WEAPON_ACTIVE  "righthand" "GreenSword"
      null_firesword_attack_arm_4              : IS_WEAPON_ACTIVE  "righthand" "FireSword" HAS_ARMORPIECE "Arm"
      null_firesword_attack_4                  : IS_WEAPON_ACTIVE  "righthand" "FireSword"
      null_elecsword_attack_4                  : IS_WEAPON_ACTIVE  "righthand" "ElecSword"
      dual_axe_attack_4                        : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      none                                     : default
      }
   torso
      {
      projectile_greensword_attack_4  : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand" IS_WEAPON_ACTIVE "righthand" "GreenSword"
      projectile_firesword_attack_4   : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand" IS_WEAPON_ACTIVE "righthand" "FireSword"
      projectile_elecsword_attack_4   : !IS_WEAPON_ACTIVE "lefthand" "Flashbang" !IS_WEAPON_ACTIVE "lefthand"  "LargeShield" ANY_WEAPON_ACTIVE "lefthand" IS_WEAPON_ACTIVE "righthand" "ElecSword"
      }

   states
      {
      KILLED_FROM_FRONT       : KILLED PAIN_DIRECTION "Front"
      KILLED                  : KILLED
      ATTACK_BLOCKED          : ATTACK_BLOCKED
      CHECK_ATTACK_LEFT_NOAIM : ANY_WEAPON_ACTIVE "lefthand" ATTACKLEFTBUTTON ANIMDONE_LEGS
      STAND                   : ANIMDONE_LEGS
      STAND                   : FALLING
      }

   exitcommands
      {
      damage_multiplier 1.0
      }
   }

state OTHER_COMBO_ATTACK1
   {
   movetype anim

   legs
      {
      dual_axe_attack_1          : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      dual_axe_attack_1_powerup  : IS_WEAPON_ACTIVE  "dualhand"  "Axe" WATER_LEVEL "40"
      dual_axe_attack_1          : IS_WEAPON_ACTIVE  "dualhand"  "Axe"
      dual_chainsword_attack_1   : IS_WEAPON_ACTIVE  "dualhand"  "ChainSword"
      }
   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      PAIN                : PAIN
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      OTHER_COMBO_ATTACK2 : ANIMDONE_LEGS ATTACKRIGHTBUTTON ONGROUND !IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      OTHER_COMBO_ATTACK2 : ANIMDONE_LEGS ATTACKLEFTBUTTON  ONGROUND
      STAND               : ANIMDONE_LEGS
      }
   }

state OTHER_COMBO_ATTACK2
   {
   movetype anim

   legs
      {
      dual_axe_attack_2          : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      dual_axe_attack_2          : IS_WEAPON_ACTIVE  "dualhand"  "Axe"
      dual_chainsword_attack_2   : IS_WEAPON_ACTIVE  "dualhand"  "ChainSword"
      }
   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      PAIN                : PAIN
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      OTHER_COMBO_ATTACK3 : ANIMDONE_LEGS ATTACKRIGHTBUTTON ONGROUND !IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      OTHER_COMBO_ATTACK3 : ANIMDONE_LEGS ATTACKLEFTBUTTON ONGROUND
      STAND               : ANIMDONE_LEGS
      }
   }

state OTHER_COMBO_ATTACK3
   {
   movetype anim

   legs
      {
      dual_axe_attack_3          : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      dual_axe_attack_3_powerup  : IS_WEAPON_ACTIVE  "dualhand"  "Axe" WATER_LEVEL "40"
      dual_axe_attack_3          : IS_WEAPON_ACTIVE  "dualhand"  "Axe"
      dual_chainsword_attack_3   : IS_WEAPON_ACTIVE  "dualhand"  "ChainSword"
      }
   states
      {
      KILLED_FROM_FRONT   : KILLED PAIN_DIRECTION "Front"
      KILLED              : KILLED
      PAIN                : PAIN
      ATTACK_BLOCKED      : ATTACK_BLOCKED
      OTHER_COMBO_ATTACK4 : ANIMDONE_LEGS ATTACKRIGHTBUTTON ONGROUND !IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      OTHER_COMBO_ATTACK4 : ANIMDONE_LEGS ATTACKLEFTBUTTON ONGROUND
      STAND               : ANIMDONE_LEGS
      }
   }

state OTHER_COMBO_ATTACK4
   {
   movetype anim

   legs
      {
      dual_axe_attack_4          : IS_WEAPON_ACTIVE  "dualhand"  "LightSword"
      dual_axe_attack_knee_4     : IS_WEAPON_ACTIVE  "dualhand"  "Axe" HAS_ARMORPIECE "Knee"
      dual_axe_attack_4          : IS_WEAPON_ACTIVE  "dualhand"  "Axe"
      dual_chainsword_attack_4   : IS_WEAPON_ACTIVE  "dualhand"  "ChainSword"
      }
   states
      {
      KILLED_FROM_FRONT       : KILLED PAIN_DIRECTION "Front"
      KILLED                  : KILLED
      PAIN                    : PAIN
      ATTACK_BLOCKED          : ATTACK_BLOCKED
      STAND                   : ANIMDONE_LEGS
      }
   }

state FALLING_AXE_ATTACK
   {
   movetype legs

   torso
      {
      dual_chainsword_attack_falling : IS_WEAPON_ACTIVE "dualhand" "ChainSword"
      dual_axe_attack_3              : IS_WEAPON_ACTIVE "dualhand" "Axe"
      dual_axe_attack_3              : IS_WEAPON_ACTIVE "dualhand" "LightSword"
      }

   states
      {
      STAND : ANIMDONE_TORSO
      }
   }

state AXE_ATTACK
   {
   movetype legs

   torso
      {
      dual_axe_strafe_left   : STRAFE_LEFT
      dual_axe_strafe_right  : STRAFE_RIGHT
      none                   : default
      }

   states
      {
      STAND : ANIMDONE_TORSO
      }
   }

state DUAL_WIELD
   {
   states
      {
      UZI_DUAL_WIELD    : DUALWIELDWEAPONS "Uzi" "DualUzi"
      NORMAL_DUAL_WIELD : default
      }
   }

state NORMAL_DUAL_WIELD
   {
   entrycommands
      {
      usedualwield
      }

   states
      {
      STAND : default
      }
   }

state UZI_DUAL_WIELD
   {
   movetype legs

   torso
      {
      raise_dual_from_lowerback : default
      }

   states
      {
      STAND : ANIMDONE_TORSO
      }
   }

state UNHOLSTER
   {
   entrycommands
      {
      holster
      }
   states
      {
      STAND : default
      }
   }