function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        CONFIRM,
        CANCEL,
        MENU
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    if (not INPUT_ON_SWITCH)
    {
        InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
	    InputDefineVerb(INPUT_VERB.CONFIRM, "confirm",    [vk_enter,   "Z"],   gp_face1);
	    InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",     [vk_shift,   "X"],   gp_face2);
	    InputDefineVerb(INPUT_VERB.MENU,    "menu",       [vk_control, "C"],   gp_face4);
    }
    else //Flip A/B over on Switch
    {
        InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
	    InputDefineVerb(INPUT_VERB.CONFIRM, "confirm",    [vk_enter,   "Z"],   gp_face2); //!
	    InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",     [vk_shift,   "X"],   gp_face1); //!
	    InputDefineVerb(INPUT_VERB.MENU,    "menu",       [vk_control, "C"],   gp_face4);
    }
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}