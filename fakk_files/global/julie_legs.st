////////////////////////////////////////////////////////////////
//
// Standing
//
////////////////////////////////////////////////////////////////

state STAND
   {
   legs
      {
      combat_idle_22_right_high  : HAS_WEAPON SLOPE_22 RIGHT_LEG_HIGH
      combat_idle_22_left_high   : HAS_WEAPON SLOPE_22 LEFT_LEG_HIGH
      combat_idle_45_right_high  : HAS_WEAPON SLOPE_45 RIGHT_LEG_HIGH
      combat_idle_45_left_high   : HAS_WEAPON SLOPE_45 LEFT_LEG_HIGH
      combat_idle_22_front       : HAS_WEAPON SLOPE_22 FACING_DOWN_SLOPE
      combat_idle_22_rear        : HAS_WEAPON SLOPE_22 FACING_UP_SLOPE
      combat_idle_45_front       : HAS_WEAPON SLOPE_45 FACING_DOWN_SLOPE
      combat_idle_45_rear        : HAS_WEAPON SLOPE_45 FACING_UP_SLOPE
      combat_idle_fullwater      : HAS_WEAPON WATER_LEVEL "90"
      combat_idle                : HAS_WEAPON

      combat_idle                : NEW_WEAPON

      stand_idle_22_right_high   : SLOPE_22 RIGHT_LEG_HIGH
      stand_idle_22_left_high    : SLOPE_22 LEFT_LEG_HIGH
      stand_idle_45_right_high   : SLOPE_45 RIGHT_LEG_HIGH
      stand_idle_45_left_high    : SLOPE_45 LEFT_LEG_HIGH
      stand_idle_22_front        : SLOPE_22 FACING_DOWN_SLOPE
      stand_idle_22_rear         : SLOPE_22 FACING_UP_SLOPE
      stand_idle_45_front        : SLOPE_45 FACING_DOWN_SLOPE
      stand_idle_45_rear         : SLOPE_45 FACING_UP_SLOPE
      stand_idle_fullwater       : WATER_LEVEL "90"
      stand_idle                 : default
      }

   states
      {
      STAND_TO_JUMP        : JUMP ONGROUND

      RUN_FORWARD          : FORWARD !BACKWARD RUN CAN_MOVE_FORWARD !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND
      WALK_FORWARD         : FORWARD !BACKWARD CAN_MOVE_FORWARD !CAN_FALL !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND

      STRAFE_RIGHT         : STRAFE_RIGHT !BACKWARD !FORWARD CAN_MOVE_RIGHT !BLOCKED "2" !FAKEPLAYERACTIVE
      STRAFE_LEFT          : STRAFE_LEFT !BACKWARD !FORWARD CAN_MOVE_LEFT !BLOCKED "2" !FAKEPLAYERACTIVE

      RUN_FORWARD          : STRAFE_RIGHT !BACKWARD RUN CAN_MOVE_RIGHT !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND
      WALK_FORWARD         : STRAFE_RIGHT FORWARD !BACKWARD CAN_MOVE_RIGHT !CAN_FALL !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND

      RUN_FORWARD          : STRAFE_LEFT !BACKWARD RUN CAN_MOVE_LEFT !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND
      WALK_FORWARD         : STRAFE_LEFT FORWARD !BACKWARD CAN_MOVE_LEFT !CAN_FALL !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND

      RUN_BACKWARD         : BACKWARD !FORWARD RUN CAN_MOVE_BACKWARD !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND
      WALK_BACKWARD        : BACKWARD !FORWARD CAN_MOVE_BACKWARD !BLOCKED "2" !FAKEPLAYERACTIVE ONGROUND

      RISE                 : RISE !ONGROUND
      FALL                 : FALLING

      STAND_TURN_LEFT      : TURNED_LEFT ONGROUND
      STAND_TURN_RIGHT     : TURNED_RIGHT ONGROUND

      RESTART_STAND        : +FACING_UP_SLOPE
      RESTART_STAND        : -FACING_UP_SLOPE
      RESTART_STAND        : +FACING_DOWN_SLOPE
      RESTART_STAND        : -FACING_DOWN_SLOPE
      RESTART_STAND        : +RIGHT_LEG_HIGH
      RESTART_STAND        : -RIGHT_LEG_HIGH
      RESTART_STAND        : +LEFT_LEG_HIGH
      RESTART_STAND        : -LEFT_LEG_HIGH
      RESTART_STAND        : +SLOPE_22
      RESTART_STAND        : -SLOPE_22
      RESTART_STAND        : +SLOPE_45
      RESTART_STAND        : -SLOPE_45
      RESTART_STAND        : +HAS_WEAPON
      RESTART_STAND        : -HAS_WEAPON
      }
   }

state RESTART_STAND
   {
   states
      {
      STAND : default
      }
   }

state RISE
   {
   movetype anim

   legs
      {
      rise_to_wind_floating : default
      }
   states
      {
      RISE_HOLD : ANIMDONE_LEGS
      }
   }

state RISE_HOLD
   {
   movetype anim

   legs
      {
      floating_in_wind : default
      }
   states
      {
      RISE_OUT : !RISE
      }
   }

state RISE_OUT
   {
   movetype anim

   legs
      {
      wind_floating_to_rise : default
      }
   states
      {
      STAND : ANIMDONE_LEGS
      }
   }

state STAND_TURN_LEFT
   {
   legs
      {
      combat_turn_left : HAS_WEAPON
      stand_turn_left : default
      }

   states
      {
      STAND                : +FORWARD
      STAND                : +BACKWARD
      STAND                : +STRAFE_LEFT
      STAND                : +STRAFE_RIGHT
      STAND                : +JUMP
      STAND                : !TURNED_LEFT
      STAND                : ANIMDONE_LEGS
      }
   }

state STAND_TURN_RIGHT
   {
   legs
      {
      combat_turn_right : HAS_WEAPON
      stand_turn_right : default
      }

   states
      {
      STAND                : +FORWARD
      STAND                : +BACKWARD
      STAND                : +STRAFE_LEFT
      STAND                : +STRAFE_RIGHT
      STAND                : +JUMP
      STAND                : !TURNED_RIGHT
      STAND                : ANIMDONE_LEGS
      }
   }

state STAND_TO_JUMP
   {
   legs
      {
      stand_to_ready : default
      }

   states
      {
      STAND_JUMP_UP        : ANIMDONE_LEGS !STRAFE_RIGHT !STRAFE_LEFT !BACKWARD !FORWARD
      STAND_JUMP           : ANIMDONE_LEGS
      FALL                 : FALLING
      }
   }

////////////////////////////////////////////////////////////////
//
// Running
//
////////////////////////////////////////////////////////////////

state RUN_FORWARD
   {
   legs
      {
      run_norm          : default
      }

   states
      {
      //RUN_STOP          : !HAS_WEAPON !FORWARD WAS_RUNNING
      STAND             : FAKEPLAYERACTIVE
      STAND             : !FORWARD
      STAND             : BLOCKED "2"
      RUN_BACKWARD      : BACKWARD !FORWARD
      WALK_FORWARD      : !RUN
      RUN_JUMP_FORWARD  : JUMP ONGROUND FORWARD
      STAND_JUMP        : JUMP ONGROUND
      FALL              : FALLING
      RISE              : RISE !ONGROUND
      }
   }

//state RUN_STOP
//   {
//   legs
//      {
//      run_to_stand : default
//      }
//
//   states
//      {
//      STAND             : ATTACKLEFT
//      STAND             : ATTACKRIGHT
//      STAND             : ANIMDONE_LEGS
//      }
//   }

state RUN_BACKWARD
   {
   legs
      {
      run_backwards        : default
      }

   states
      {
      STAND                : FAKEPLAYERACTIVE
      STAND                : !BACKWARD
      STAND                : BLOCKED "2"
      STAND                : !CAN_MOVE_BACKWARD
      STAND_JUMP           : JUMP ONGROUND

      WALK_BACKWARD        : !RUN
      FALL                 : FALLING
      RISE                 : RISE !ONGROUND
      }
   }

////////////////////////////////////////////////////////////////
//
// Walking
//
////////////////////////////////////////////////////////////////

state WALK_FORWARD
   {
   legs
      {
      walk_norm         : default
      }

   states
      {
      STAND                : FAKEPLAYERACTIVE
      STAND                : CAN_FALL
      STAND                : BLOCKED "2"
      STAND                : !FORWARD
      RUN_FORWARD          : RUN

      STAND_JUMP           : JUMP ONGROUND

      FALL                 : FALLING
      RISE                 : RISE !ONGROUND
      }
   }

state WALK_BACKWARD
   {
   legs
      {
      walk_back                    : default
      }

   states
      {
      STAND                : FAKEPLAYERACTIVE
      STAND                : !BACKWARD
      STAND                : BLOCKED "2"
      STAND                : !CAN_MOVE_BACKWARD
      STAND_JUMP           : JUMP ONGROUND
      RUN_BACKWARD         : RUN
      FALL                 : FALLING
      RISE                 : RISE !ONGROUND
      }
   }

////////////////////////////////////////////////////////////////
//
// Strafing
//
////////////////////////////////////////////////////////////////

state STRAFE_LEFT
   {
   legs
      {
      walk_strafe_left        : !RUN !HAS_WEAPON
      combat_walk_strafe_left : !RUN HAS_WEAPON
      run_strafe_left         : default
      }

   states
      {
      STAND                : FAKEPLAYERACTIVE
      STAND                : BLOCKED "2"
      STAND                : !STRAFE_LEFT
      STAND                : STRAFE_RIGHT
      STAND                : FORWARD
      STAND                : BACKWARD
      STAND                : +RUN
      STAND                : -RUN

      STAND_JUMP           : JUMP ONGROUND

      FALL                 : FALLING
      RISE                 : RISE !ONGROUND
      }
   }

state STRAFE_RIGHT
   {
   legs
      {
      walk_strafe_right          : !RUN !HAS_WEAPON
      combat_walk_strafe_right   : !RUN HAS_WEAPON
      run_strafe_right           : default
      }

   states
      {
      STAND                : FAKEPLAYERACTIVE
      STAND                : BLOCKED "2"
      STAND                : !STRAFE_RIGHT
      STAND                : STRAFE_LEFT
      STAND                : FORWARD
      STAND                : BACKWARD
      STAND                : +RUN
      STAND                : -RUN

      STAND_JUMP           : JUMP ONGROUND

      FALL                 : FALLING
      RISE                 : RISE !ONGROUND
      }
   }

////////////////////////////////////////////////////////////////
//
// Falling
//
////////////////////////////////////////////////////////////////

state FALL
   {
   legs
      {
      fall : default
      }

   states
      {
      RISE           : RISE
      LAND           : ONGROUND
      }
   }

state LAND
   {
   states
      {
      HARD_LAND   : HARD_IMPACT
      STAND       : default
      }
   }

state HARD_LAND
   {
   legs
      {
      land : default
      }

   states
      {
      JUMP_READY_TO_STAND : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Jumping up
//
////////////////////////////////////////////////////////////////

state STAND_JUMP_UP
   {
   legs
      {
      ready_to_jump_up_to_rise : default
      }

   states
      {
      JUMP_UP_RISE   : ANIMDONE_LEGS
      }
   }

state JUMP_UP_RISE
   {
   legs
      {
      jumpup_rise : default
      }

   states
      {
      JUMP_UP_FALL            : FALLING
      JUMP_UP_LAND            : ONGROUND
      }
   }

state JUMP_UP_FALL
   {
   legs
      {
      jump_up_fall : default
      }

   states
      {
      JUMP_UP_LAND            : ONGROUND
      }
   }

state JUMP_UP_LAND
   {
   legs
      {
      jump_up_fall_to_land_to_ready : default
      }

   states
      {
      STAND_JUMP_UP        : JUMP !FORWARD !BACKWARD !STRAFE_LEFT !STRAFE_RIGHT
      STAND_JUMP           : JUMP

      JUMP_UP_FALL         : FALLING
      JUMP_READY_TO_STAND  : default
      }
   }

////////////////////////////////////////////////////////////////
//
// Standard Jump Starts
//
////////////////////////////////////////////////////////////////

state STAND_JUMP
   {
   legs
      {
      ready_to_jump_fwdleft_to_rise    : FORWARD STRAFE_LEFT !STRAFE_RIGHT
      ready_to_jump_fwdright_to_rise   : FORWARD STRAFE_RIGHT !STRAFE_LEFT
      ready_to_jump_fwd_to_rise        : FORWARD

      ready_to_jump_backleft_to_rise   : BACKWARD STRAFE_LEFT !STRAFE_RIGHT
      ready_to_jump_backright_to_rise  : BACKWARD STRAFE_RIGHT !STRAFE_LEFT
      ready_to_jump_backward_to_rise   : BACKWARD

      ready_to_jump_left_to_rise       : STRAFE_LEFT
      ready_to_jump_right_to_rise      : STRAFE_RIGHT

      // shouldn't be possible, but just in case
      ready_to_jump_fwd_to_rise        : default
      }

   states
     {
     JUMP_RISE : ANIMDONE_LEGS
     }
   }

////////////////////////////////////////////////////////////////
//
// Running Jump
//
////////////////////////////////////////////////////////////////

state RUN_JUMP_FORWARD
   {
   legs
      {
      run_to_jump_forwardleft_to_rise  : STRAFE_LEFT !STRAFE_RIGHT
      run_to_jump_forwardright_to_rise : STRAFE_RIGHT !STRAFE_LEFT
      run_to_jump_forward_to_rise      : default
      }

   states
      {
      RUN_JUMP_RISE : ANIMDONE_LEGS
      }
   }

state RUN_JUMP_RISE
   {
   legs
      {
      rise : default
      }

   states
      {
      RUN_JUMP_RISE_TO_FALL   : FALLING WATER_LEVEL "90"
      JUMP_FALL               : FALLING
      JUMP_LAND               : ONGROUND
      }
   }

state RUN_JUMP_RISE_TO_FALL
   {
   legs
      {
      rise_to_fall_flip : default
      }

   states
      {
      JUMP_LAND            : ONGROUND
      JUMP_FALL            : ANIMDONE_LEGS
      }
   }

////////////////////////////////////////////////////////////////
//
// Standard Jump States
//
////////////////////////////////////////////////////////////////

state JUMP_RISE
   {
   legs
      {
      rise : default
      }

   states
      {
      JUMP_RISE_TO_FALL       : FALLING
      JUMP_LAND               : ONGROUND
      }
   }

state JUMP_RISE_TO_FALL
   {
   legs
      {
      rise_to_fall : default
      }

   states
      {
      JUMP_LAND            : ONGROUND
      JUMP_FALL            : ANIMDONE_LEGS
      }
   }

state JUMP_FALL
   {
   legs
      {
      fall : default
      }

   states
      {
      JUMP_LAND            : ONGROUND
      }
   }

state JUMP_LAND
   {
   states
      {
      JUMP_LAND_IMPACT     : JUMP
      STAND                : !HARD_IMPACT FORWARD
      STAND                : !HARD_IMPACT BACKWARD
      STAND                : !HARD_IMPACT STRAFE_RIGHT
      STAND                : !HARD_IMPACT STRAFE_LEFT
      JUMP_LAND_IMPACT     : default
      }
   }

state JUMP_LAND_IMPACT
   {
   legs
      {
      fall_to_land_to_ready : default
      }

   states
      {
      STAND_JUMP_UP        : JUMP !FORWARD !BACKWARD !STRAFE_LEFT !STRAFE_RIGHT
      STAND_JUMP           : JUMP
      FALL                 : FALLING
      JUMP_READY_TO_STAND  : ANIMDONE_LEGS
      }
   }

state JUMP_READY_TO_STAND
   {
   legs
      {
      ready_to_stand : default
      }

   states
      {
      STAND : ANIMDONE_LEGS
      }
   }